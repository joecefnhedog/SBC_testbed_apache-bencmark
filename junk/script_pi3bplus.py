import socket
import subprocess
import os
import time
import sys
import shutil#deleting folders
import numpy as np
#import commands
#import pistack.comms, pistack.conversions
from subprocess import Popen, PIPE
class client(object):
    s = socket.socket(
        socket.AF_INET, socket.SOCK_DGRAM)
    def send(self, data, ip):
        self.s.sendto(bytes(data,), (ip, 5000))
#C = pistack.comms.Comms("/dev/ttyUSB0", 9600)
stackList = [(9, 1),(9, 0),(14, 1),(14, 0),(1, 1),(1, 0),(12, 1),(12, 0),(2, 1),(2, 0)]        
nPi = 10
n=10
clientList = [client() for count in xrange(nPi)]#pi clients

ipList = (["192.168.1.138","192.168.1.237","192.168.1.19", "192.168.1.29", 
           "192.168.1.38", "192.168.1.107", "192.168.1.119", "192.168.1.205",
           "192.168.1.44", "192.168.1.243"])#pi 3b+ ip
#haproxy file lines to add
toFileList = ["server pi-1  192.168.1.138:80\n", 
              "server pi-2  192.168.1.237:80\n", 
              "server pi-3  192.168.1.19:80\n",
              "server pi-4  192.168.1.29:80\n",
              "server pi-5  192.168.1.38:80\n",
              "server pi-6  192.168.1.107:80\n",
              "server pi-7  192.168.1.119:80\n",
              "server pi-8  192.168.1.205:80\n",
              "server pi-9  192.168.1.44:80\n",
              "server pi-10 192.168.1.243:80\n"]
def power_on_pi(p):
    p = Popen(["sudo python3 on.py " + str(stackList[p][0]) + " " + str(stackList[p][1])], stdin=PIPE, shell=True)
    #C.pi_on(stackList[p][0],stackList[p][1])
    #print("sent power on via pistack, now waiting to boot"+str(p+1))
    time.sleep(10)
def funcSend1(i1,j1):
    for k in range(j1+1):
        print('sending - 1-'+ipList[k])
        clientList[k].send('1,'+ str(i1) + ',' + str(j1),ipList[k])
def funcSend2(i2,j2):
    for l in range(j2+1):
        print('sending - 2-'+ipList[l])
        clientList[l].send('2,'+ str(i2) + ',' + str(j2),ipList[l])
  
def send_update(u):
    p = Popen(["ssh-keygen -R "+ipList[u]], stdin=PIPE, shell=True)
    p = Popen(["scp -o StrictHostKeyChecking=no -i ssh-key-for-fruit update_packages.py root@" +ipList[u]+":/root"], stdin=PIPE, shell=True)
    time.sleep(2)
    p = Popen(["scp -o StrictHostKeyChecking=no -i ssh-key-for-fruit nginx_files.py root@" +ipList[u]+":/root"], stdin=PIPE, shell=True)
    time.sleep(2)
    
def update(u2):
    p = Popen(["ssh -i ssh-key-for-fruit root@" +ipList[u2]+" 'python3 update_packages.py'"], stdin=PIPE, shell=True)
    time.sleep(40)
    
    print("updated packeges on pi-"+str(u2+1))
    p = Popen(["ssh -i ssh-key-for-fruit root@" +ipList[u2]+" 'python3 nginx_files.py'"], stdin=PIPE, shell=True)
    print("adding data files on pi-"+str(u2+1))
    time.sleep(20)
    
    p = Popen(["scp -o StrictHostKeyChecking=no -i ssh-key-for-fruit nginx.conf root@" +ipList[u2]+":/etc/nginx"], stdin=PIPE, shell=True)
    time.sleep(5)
    p = Popen(["scp -o StrictHostKeyChecking=no -i ssh-key-for-fruit index.html root@" +ipList[u2]+":/www"], stdin=PIPE, shell=True)
    time.sleep(5)
    p = Popen(["ssh -i ssh-key-for-fruit root@" +ipList[u2]+" 'rc-service nginx start'"], stdin=PIPE, shell=True)
    time.sleep(5)
    p = Popen(["ssh -i ssh-key-for-fruit root@" +ipList[u2]+" 'nginx -t'"], stdin=PIPE, shell=True)
    print "changed nginx.conf and added the index.html file"
    time.sleep(5)
    
def send_script(k):
    p = Popen(["ssh-keygen -R "+ipList[k]], stdin=PIPE, shell=True)
    #p = Popen(["scp -o StrictHostKeyChecking=no -i ssh-key-for-fruit local_script.py root@" +ipList[k]+":/root"], stdin=PIPE, shell=True)
    p = Popen(["scp -o StrictHostKeyChecking=no -i ssh-key-for-fruit local_script.py root@" +ipList[k]+":/root"], stdin=PIPE, shell=True)
    time.sleep(5) 
#function to start the listening script, on each of the pi's - when necessary.
def startScript(j3):
    for m in range(j3+1):
        #p = Popen(["ssh -i ssh-key-for-fruit root@" +ipList[m]+" 'nohup python local_script.py "+ipList[m]+"' "], stdin=PIPE, shell=True)
        p = Popen(["ssh -o StrictHostKeyChecking=no -i ssh-key-for-fruit root@" +ipList[m]+" 'nohup python local_script.py "+ipList[m]+"' "], stdin=PIPE, shell=True)
        print("Started script on pi-"+str(m+1))
        time.sleep(0.1)#let the script start up and start listening.
        
#function to modify the number of pi being workloaded over.
def modifyHaproxy(j4):
    with open("/etc/haproxy/haproxy.cfg", "a") as f:
         f.write(toFileList[j4])
    os.system("systemctl restart haproxy")
    time.sleep(5)#let haproxy restart.
    print("haproxy edited and left to restart for 5 seconds.")


def run_ab():
    folder="ab"
    try:
        shutil.rmtree(folder)
        print ("file was deleted- /" + folder)
    except OSError as e:
        print ("No worries, nothing to see here: %s - %s." % (e.filename, e.strerror))
    

    
    os.mkdir(folder)
    os.system("sudo chmod 777 ab/")
    time.sleep(1)    
    print("going to start the picoscope logging")
    p = Popen(["nohup sudo python3 pico_python.py &"], stdin=PIPE, shell=True)
    picoStart = time.time()
    piStart = nPi*[0]
    apacheBenchStart = np.zeros((nPi,n))
    time.sleep(30)
    for j in range(nPi):
        #print(str(j)+"test")
        print("powering on pi-"+str(j+1))
        piStart[j] =time.time()-picoStart
        power_on_pi(j)
        #print("pi should have powerered on")
        s2 = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        #wait host to finish reboot, check specific port connection (usually ssh port if you want to exec remote commands)
        while True:
            try:
                s2.connect((ipList[j], 22))
                print "Port 22 reachable on pi-"+str(j+1)
                break
            except socket.error as e:
                print "booting "+str(j+1)+"..."
                time.sleep(1)
        s2.close()
        print "continuing"
        time.sleep(10)
        print(piStart[j])
        #print(str(j)+"test")
        modifyHaproxy(j)
        #print(str(j)+"test")
        send_update(j)
        update(j)
        send_script(j)
        for i in range(n):
            print("#pi's="+str(j+1) +". Iteration = "+str(i+1))
            startScript(j)
            time.sleep(20)
            funcSend1(i,j)
            #time.sleep(0.1)
            #os.system("ab -n 100000 -c 1000 http://192.168.1.150/0K.dat >" + str(i) + '-'+str(j) + ".txt 2>&1")#apacheBench test
            #os.system("ab -n 100000 -c 1000 -e ab"+str(i)+"-"+str(j)+".csv http://192.168.1.150/0K.dat >" + str(i) + '-'+str(j) + ".txt 2>&1")#apacheBench test
            os.system("ab -n 100000 -c 1000 -e ab/ab"+str(i)+"-"+str(j)+".csv http://192.168.1.150/0K.dat")#apacheBench test
            apacheBenchStart[j][i]=time.time()-picoStart
            print(apacheBenchStart[j][i])
            funcSend2(i,j)
            time.sleep(1)
    f=open("ab/picoTimeData.txt","w+")
    f.write(str(picoStart))
    f.close()
    g=open("ab/piTimeData.txt","w+")
    g.write(str(piStart))
    g.close()
    h=open("ab/apacheBench.txt","w+")
    h.write(str(apacheBenchStart))
    h.close()
run_ab()
for i in range(nPi):
    clientList[i].send("3,0,0", ipList[i])
print("Sent 3...")
print("Stopping")

