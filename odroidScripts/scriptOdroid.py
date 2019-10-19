import socket
import subprocess
import os
import time
import sys
import shutil#deleting folders
import numpy as np
from subprocess import Popen, PIPE
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
#testList = (["0K","1K","10K","100K"])
testList = (["10K"])

testTime = ([700+61*(n)*(nPi)])
#testTime = ([550+50*(n)*(nPi),700+70*(n)*(nPi),800+100*(n)*(nPi),1300+160*(n)*(nPi)])
def send_script(i):
    p = Popen(["sudo sshpass -p odroid scp -o StrictHostKeyChecking=no local_script.py odroid@"+ipList[i]+":/home/odroid"], stdin=PIPE, shell=True)

    
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

def ssh_copy_id(j):
    p = Popen(["sshpass -p odroid ssh-copy-id odroid@" +ipList[j]], stdin=PIPE, shell=True)
    time.sleep(5)


ipList = (["192.168.1.200","192.168.1.33","192.168.1.38", "192.168.1.52", 
           "192.168.1.41", "192.168.1.50", "192.168.1.51", "192.168.1.66",
           "192.168.1.64", "192.168.1.67"])#pi 3b+ ip
#haproxy file lines to add
toFileList = ["server pi-1  192.168.1.200:80\n", 
              "server pi-2  192.168.1.33:80\n", 
              "server pi-3  192.168.1.38:80\n",
              "server pi-4  192.168.1.52:80\n",
              "server pi-5  192.168.1.41:80\n",
              "server pi-6  192.168.1.50:80\n",
              "server pi-7  192.168.1.51:80\n",
              "server pi-8  192.168.1.66:80\n",
              "server pi-9  192.168.1.64:80\n",
              "server pi-10 192.168.1.67:80\n"]


def startScript(j3):
    for m in range(j3+1):
        p = Popen(["sshpass -p odroid ssh -o StrictHostKeyChecking=no odroid@" +ipList[m]+" 'nohup python local_script.py "+ipList[m]+"' "], stdin=PIPE, shell=True)
        print("Started script on pi-"+str(m+1))
        time.sleep(0.01)#let the script start up and start listening.

def power_off(k):
    print("shutting down "+str(k+1))
    p = Popen(["ssh-keygen -R "+ipList[k]], stdin=PIPE, shell=True)
    #p = Popen(["ssh -o StrictHostKeyChecking=no odroid@" +(ipList[k])+ " poweroff"], stdin=PIPE, shell=True)
    p = Popen(["sshpass -p odroid ssh -o StrictHostKeyChecking=no odroid@" +(ipList[k])+ " sudo poweroff"], stdin=PIPE, shell=True)
def kill_power(p):
    print("now killing power to "+str(p+1))
    p = Popen(["sudo python3 off.py " + str(stackList[p][0]) + " " + str(stackList[p][1])], stdin=PIPE, shell=True)
    time.sleep(1)#this will run in the background
    

def power_on_pi(p):
    #p = Popen(["sshpass -p odroid ssh odroid@" +ipList[p]+" 'sudo poweroff' "], stdin=PIPE, shell=True)
    p = Popen(["sudo python3 on.py " + str(stackList[p][0]) + " " + str(stackList[p][1])], stdin=PIPE, shell=True)
    time.sleep(7)


def funcSend1(i1,j1):
    for k in range(j1+1):
        print('sending - 1-'+ipList[k])
        clientList[k].send('1,'+ str(i1) + ',' + str(j1),ipList[k])
def funcSend2(i2,j2):
    for l in range(j2+1):
        print('sending - 2-'+ipList[l])
        clientList[l].send('2,'+ str(i2) + ',' + str(j2),ipList[l])    

#print "powering off"
#print (ipList[1])
#print (str(ipList[1]))
def power_off_all():
    for po in range (nPi):
        power_off(po)
        time.sleep(0.1)
    time.sleep(40)
    for kp in range (nPi):
        kill_power(kp)
        time.sleep(1)
    time.sleep(2)
    



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

def deleteFiles(pi):
    for idx in range(pi):
        #p = Popen(["sshpass -p odroid ssh -o StrictHostKeyChecking=no odroid@" +ipList[idx]+" 'find . ! -name \'local_script.py\' -type f -exec rm -f {} +' "], stdin=PIPE, shell=True)
        p = Popen(["sshpass -p odroid ssh -o StrictHostKeyChecking=no odroid@" +ipList[idx]+" 'rm -r data' "], stdin=PIPE, shell=True)
        time.sleep(20)
#    find . ! -name 'file.txt' -type f -exec rm -f {} +




    
def get_data(pi,test):
    for jk in range(pi):
        os.makedirs(testList[test]+"/pi"+str(jk+1))
        time.sleep(2)
        os.system("sudo chmod 777 "+str(testList[test])+"/pi"+str(jk+1)+"/")
        time.sleep(2)    
        p = Popen(["sudo sshpass -p odroid scp -o StrictHostKeyChecking=no -r odroid@"+ipList[jk]+":/home/odroid/data /home/lunet/eljb13/Dropbox/rpi_testbed/odroidScripts/"+testList[test]+"/pi"+str(jk+1)], stdin=PIPE, shell=True)
        #p = Popen(["sshpass -p odroid ssh -o StrictHostKeyChecking=no odroid@" +ipList[m]+" 'nohup python local_script.py "+ipList[m]+"' "], stdin=PIPE, shell=True)
        print "getting files"
        time.sleep(40)
        os.system("sudo chmod -R 777 "+testList[test]+"/pi"+str(jk+1)+"/data/")
        time.sleep(20)







def run_ab():
    #comeback_in()
    print("comeback in " + str(comeback_in())+" seconds or - "+str(comeback_in()/60)+" mins or - "+str((comeback_in()/60)/60)+" hours" )
    #time.sleep(30)
    set_haproxy_file()
    time.sleep(1)
    for ab in range(len(testList)):
        folder=str(testList[ab])
        os.mkdir(folder)
        os.system("sudo chmod 777 "+str(testList[ab])+"/")
        print ("sudo chmod 777 "+str(testList[ab])+"/")
        os.makedirs(testList[ab]+"/ab")
        os.system("sudo chmod 777 "+str(testList[ab])+"/ab/")
        #try:
        #    shutil.rmtree(folder)
        #    print ("file was deleted- /" + folder)
        #except OSError as e:
        #    print ("No worries, nothing to see here: %s - %s." % (e.filename, e.strerror))
        
        
        print("going to start the picoscope logging")
        time.sleep(1)    
        p = Popen(["nohup sudo python3 pico_python.py "+str(testTime[ab])+" &"], stdin=PIPE, shell=True)
        picoStart = time.time()
        piStart = nPi*[0]
        apacheBenchStart = np.zeros((nPi,n))
        time.sleep(30)
        
        for j in range(nPi):
            #print(str(j)+"test")
            print("powering on pi-"+str(j+1))
            piStart[j] =time.time()-picoStart
            power_on_pi(j)
            time.sleep(50)
            print("checking if pi is reachable on port22")
            s2 = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            #wait host to finish reboot, check specific port connection (usually ssh port if you want to exec remote commands)
            while True:
                try:
                    s2.connect((ipList[j], 22))
                    print "Port 22 reachable on pi-"+str(j+1)
                    break
                except socket.error as e:
                    power_off(j)
                    time.sleep(10)
                    kill_power(j)
                    time.sleep(50)
                    power_on_pi(j)
                    print "re-booting "+str(j+1)+"...wait 50"
                    time.sleep(50)                    
                    #time.sleep(1)
            #s2.close()
            print "continuing"
            time.sleep(10)
            print(piStart[j])
            #print(str(j)+"test")
            ssh_copy_id(j)
            modifyHaproxy(j)
            #print(str(j)+"test")
            #send_update(j)
            #update(j)
            #nginx(j)
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
                time.sleep(5)
                funcSend2(i,j)
                time.sleep(5)
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
        os.system("sudo chmod -R 777 "+testList[ab]+"/pi"+str(j+1)+"/data/")
        print "got data"
        deleteFiles(nPi)
        print "del files"
        set_haproxy_file()
        print "lines removed from haproxy"
        time.sleep(20)
        power_off_all()
        #os.system("sudo python3 power_off.py")
        #time.sleep(70)
        #while (time.time()-picoStart)<(testTimeSum(ab)):
        while (time.time()-picoStart)<(testTime[ab]):    
            #print "pico is still loggging, wait until" + str(time.time()-picoStart) +">"+str(testTimeSum(ab))#testTime[idx]
            print "pico is still loggging, wait until" + str(time.time()-picoStart) +">"+str(testTime[ab])#testTime[idx]
            time.sleep(10)
        print "pico stopped logging, waiting until files were saved:"
        print(time.time()-picoStart)
        time.sleep(25)
run_ab()
#power_off_all()
for i in range(nPi):
    clientList[i].send("3,0,0", ipList[i])
print("Sent 3...")
print("Stopping")

        