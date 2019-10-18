import socket
import subprocess
import os
import time
import sys
import shutil#deleting folders
import numpy as np
from subprocess import Popen, PIPE
class client(object):
    s = socket.socket(
        socket.AF_INET, socket.SOCK_DGRAM)
    def send(self, data, ip):
        self.s.sendto(bytes(data,), (ip, 5000))
#C = pistack.comms.Comms("/dev/ttyUSB0", 9600)
stackList = [(9, 1),(9, 0),(14, 1),(14, 0),(1, 1),(1, 0),(12, 1),(12, 0),(2, 1),(2, 0)]        
nPi =10
n=5
clientList = [client() for count in xrange(nPi)]#pi clients
testList = (["0K","1K","10K","100K"])#,"10K","100K"])
#testList = (["1K","10K","100K"])#,"10K","100K"])

testTime = ([550+200*(n)*(nPi),700+200*(n)*(nPi),800+200*(n)*(nPi),1300+500*(n)*(nPi)])
#testTime = ([700+200*(n)*(nPi),800+200*(n)*(nPi),1300+500*(n)*(nPi)])

def comeback_in():
    count=0
    for idx in range (len(testTime)):
        count+=testTime[idx]
    return count
def testTimeSum(ab_idx):
    tt=0
    for idx in range(ab_idx+1):
        tt+=testTime[idx]
    return tt

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

def sendDockerFilesNginx(d):
    p = Popen(["ssh-keygen -R "+ipList[d]], stdin=PIPE, shell=True)
    p = Popen(["scp -o StrictHostKeyChecking=no -i ssh-key-for-fruit Dockerfile root@" +ipList[d]+":/root"], stdin=PIPE, shell=True)
    time.sleep(4)
    p = Popen(["scp -o StrictHostKeyChecking=no -i ssh-key-for-fruit index.html root@" +ipList[d]+":/root"], stdin=PIPE, shell=True)
    time.sleep(4)
    p = Popen(["scp -o StrictHostKeyChecking=no -i ssh-key-for-fruit datFiles.py root@" +ipList[d]+":/root"], stdin=PIPE, shell=True)
    time.sleep(4)
    p = Popen(["ssh -i ssh-key-for-fruit root@" +ipList[d]+" 'python3 datFiles.py'"], stdin=PIPE, shell=True)
    time.sleep(225)


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
        time.sleep(0.01)#let the script start up and start listening.
        
#function to modify the number of pi being workloaded over.
def modifyHaproxy(j4):
    with open("/etc/haproxy/haproxy.cfg", "a") as f:
         f.write(toFileList[j4])
    #os.system("sudo systemctl restart haproxy")
    time.sleep(5)#let haproxy restart.
    print("haproxy edited.")
def set_haproxy_file():
    if os.path.exists("/etc/haproxy/haproxy.cfg"):
        os.system('sudo rm /etc/haproxy/haproxy.cfg')
    else:
        print('File haproxy does not exist in /etc/haproxy/')
    
    time.sleep(2)
    os.system('sudo cp haproxy.cfg /etc/haproxy/'  )
    time.sleep(2)
def get_data(pi,test):
    for jk in range(pi):
        os.makedirs(testList[test]+"/pi"+str(jk+1))
        time.sleep(2)
        os.system("sudo chmod 777 "+str(testList[test])+"/pi"+str(jk+1)+"/")
        time.sleep(2)    
        p = Popen(["scp -i ssh-key-for-fruit -r root@"+ipList[jk]+":/root/ /home/lunet/eljb13/Dropbox/DockerTests/"+testList[test]+"/pi"+str(jk+1)], stdin=PIPE, shell=True)
        print "getting files"
        time.sleep(100)
        os.system("sudo chmod -R 777 "+testList[test]+"/pi"+str(jk+1)+"/root/")
        time.sleep(80)



#def run():
#    sendDockerFilesNginx(0)
#run()
def run_ab():
    print("comeback in " + str(comeback_in())+" seconds or - "+str(comeback_in()/60)+" mins or - "+str((comeback_in()/60)/60)+" hours" )
    set_haproxy_file()
    time.sleep(1)
    for ab in range(len(testList)):
        folder=str(testList[ab])
        os.mkdir(folder)
        os.system("sudo chmod 777 "+str(testList[ab])+"/")
        print ("sudo chmod 777 "+str(testList[ab])+"/")
        os.makedirs(testList[ab]+"/ab")
        os.system("sudo chmod 777 "+str(testList[ab])+"/ab/")
        print("going to start the picoscope logging")
        time.sleep(1)    
        p = Popen(["nohup sudo python3 pico_python.py "+str(testTime[ab])+" &"], stdin=PIPE, shell=True)
        picoStart = time.time()
        piStart = nPi*[0]
        apacheBenchStart = np.zeros((nPi,n))
        time.sleep(30)
        
        for j in range(nPi):
            print("powering on pi-"+str(j+1))
            piStart[j] =time.time()-picoStart
            power_on_pi(j)
            s2 = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
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
            sendDockerFilesNginx(j)
            time.sleep(20)
            os.system("sudo systemctl restart haproxy")
            time.sleep(5)#let haproxy restart.
            print("haproxy left to restart for 5 seconds.")

            send_script(j)
            for i in range(n):
                print("#pi's="+str(j+1) +". Iteration = "+str(i+1))
                startScript(j)
                time.sleep(20)
                funcSend1(i,j)
                #time.sleep(0.1)
                os.system("ab -s 120 -n 100000 -c 1000 -e "+testList[ab]+"/ab"+str(i)+"-"+str(j)+".csv http://192.168.1.150/"+testList[ab]+".dat")#apacheBench test
                apacheBenchStart[j][i]=time.time()-picoStart
                print(apacheBenchStart[j][i])
                funcSend2(i,j)
                time.sleep(1)
        f=open(testList[ab]+"/ab/picoTimeData"+str(ab)+".txt","w+")
        f.write(str(picoStart))
        f.close()
        g=open(testList[ab]+"/ab/piTimeData"+str(ab)+".txt","w+")
        g.write(str(piStart))
        g.close()
        h=open(testList[ab]+"/ab/apacheBench"+str(ab)+".txt","w+")
        h.write(str(apacheBenchStart))
        h.close()
        print "going to get data"
        get_data(nPi,ab)
        os.system("sudo chmod -R 777 "+testList[ab]+"/pi"+str(j+1)+"/root/")
        print "got data"
        set_haproxy_file()
        print "lines removed from haproxy"
        time.sleep(20)
        os.system("sudo python3 power_off.py")
        while (time.time()-picoStart)<(testTime[ab]):    
            print "pico is still loggging, wait until" + str(time.time()-picoStart) +">"+str(testTime[ab])#testTime[idx]
            time.sleep(10)
        print "pico stopped logging, waiting until files were saved:"
        print(time.time()-picoStart)
        time.sleep(125)
run_ab()
for i in range(nPi):
    clientList[i].send("3,0,0", ipList[i])
print("Sent 3...")
print("Stopping")
