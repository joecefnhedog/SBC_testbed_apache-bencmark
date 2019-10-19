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


def sendFiles(i):
    p = Popen(["sudo sshpass -p odroid scp -o StrictHostKeyChecking=no index.html odroid@"+ipList[i]+":/home/odroid"], stdin=PIPE, shell=True)
    p = Popen(["sudo sshpass -p odroid scp -o StrictHostKeyChecking=no Dockerfile odroid@"+ipList[i]+":/home/odroid"], stdin=PIPE, shell=True)
    p = Popen(["sudo sshpass -p odroid scp -o StrictHostKeyChecking=no 0K.dat odroid@"+ipList[i]+":/home/odroid"], stdin=PIPE, shell=True)
    p = Popen(["sudo sshpass -p odroid scp -o StrictHostKeyChecking=no 1K.dat odroid@"+ipList[i]+":/home/odroid"], stdin=PIPE, shell=True)
    p = Popen(["sudo sshpass -p odroid scp -o StrictHostKeyChecking=no 10K.dat odroid@"+ipList[i]+":/home/odroid"], stdin=PIPE, shell=True)
    p = Popen(["sudo sshpass -p odroid scp -o StrictHostKeyChecking=no 100K.dat odroid@"+ipList[i]+":/home/odroid"], stdin=PIPE, shell=True)
    time.sleep(10)
def deletefiles(m):
    p = Popen(["sshpass -p odroid ssh -o StrictHostKeyChecking=no odroid@" +ipList[m]+" 'find . -maxdepth 1 -type f -delete' "], stdin=PIPE, shell=True)
    time.sleep(5)
def uninstallEtc(m):
    p = Popen(["ssh-keygen -R "+ipList[m]], stdin=PIPE, shell=True)
    p = Popen(["sshpass -p odroid ssh -o StrictHostKeyChecking=no odroid@" +ipList[m]+" 'sudo systemctl stop nginx' "], stdin=PIPE, shell=True)
    time.sleep(5)
    p = Popen(["sshpass -p odroid ssh -o StrictHostKeyChecking=no odroid@" +ipList[m]+" 'sudo killall apt apt-get' "], stdin=PIPE, shell=True)
    time.sleep(5)
    p = Popen(["sshpass -p odroid ssh -o StrictHostKeyChecking=no odroid@" +ipList[m]+" 'sudo rm /var/lib/apt/lists/lock' "], stdin=PIPE, shell=True)
    time.sleep(5)
    p = Popen(["sshpass -p odroid ssh -o StrictHostKeyChecking=no odroid@" +ipList[m]+" 'sudo rm /var/cache/apt/archives/lock' "], stdin=PIPE, shell=True)
    time.sleep(5)
    p = Popen(["sshpass -p odroid ssh -o StrictHostKeyChecking=no odroid@" +ipList[m]+" 'sudo rm /var/lib/dpkg/lock' "], stdin=PIPE, shell=True)
    time.sleep(5)
    
    p = Popen(["sshpass -p odroid ssh -o StrictHostKeyChecking=no odroid@" +ipList[m]+" 'sudo dpkg --configure -a' "], stdin=PIPE, shell=True)
    time.sleep(5)
    p = Popen(["sshpass -p odroid ssh -o StrictHostKeyChecking=no odroid@" +ipList[m]+" 'sudo apt-get -y remove nginx nginx-common' "], stdin=PIPE, shell=True)
    time.sleep(5)
    p = Popen(["sshpass -p odroid ssh -o StrictHostKeyChecking=no odroid@" +ipList[m]+" 'sudo apt-get -y purge nginx nginx-common' "], stdin=PIPE, shell=True)
    time.sleep(5)
    p = Popen(["sshpass -p odroid ssh -o StrictHostKeyChecking=no odroid@" +ipList[m]+" 'sudo apt-get -y autoremove' "], stdin=PIPE, shell=True)
    time.sleep(5)
    p = Popen(["sshpass -p odroid ssh -o StrictHostKeyChecking=no odroid@" +ipList[m]+" 'sudo apt-get -y install emacs' "], stdin=PIPE, shell=True)
    time.sleep(5)
    p = Popen(["sshpass -p odroid ssh -o StrictHostKeyChecking=no odroid@" +ipList[m]+" 'sudo apt-get -y install docker.io' "], stdin=PIPE, shell=True)
    time.sleep(120)
    p = Popen(["sshpass -p odroid ssh -o StrictHostKeyChecking=no odroid@" +ipList[m]+" 'sudo docker build -t simple-nginx .' "], stdin=PIPE, shell=True)
    time.sleep(12)
    p = Popen(["sshpass -p odroid ssh -o StrictHostKeyChecking=no odroid@" +ipList[m]+" 'sudo docker run --rm -it -p 80:80 -d simple-nginx' "], stdin=PIPE, shell=True)
    time.sleep(12)
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

def power_off_all():
    for po in range (nPi):
        power_off(po)
        time.sleep(0.1)
    time.sleep(40)
    for kp in range (nPi):
        kill_power(kp)
        time.sleep(1)
    time.sleep(2)
 
def run_ab():
    for j in range(nPi):
        print("powering on pi-"+str(j+1))
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
        deletefiles(j)
        time.sleep(5)
        sendFiles(j)
        time.sleep(30)
        uninstallEtc(j)
        time.sleep(30)

    
#run_ab()
power_off_all()
for i in range(nPi):
    clientList[i].send("3,0,0", ipList[i])
print("Sent 3...")
print("Stopping")

        
