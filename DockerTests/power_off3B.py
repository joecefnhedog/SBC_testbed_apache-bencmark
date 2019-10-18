import socket
import subprocess
import os
import time
import pistack.comms, pistack.conversions
from subprocess import Popen, PIPE
ipList = (["192.168.1.36","192.168.1.74","192.168.1.94", "192.168.1.210", 
           "192.168.1.81", "192.168.1.161", "192.168.1.175", "192.168.1.135",
           "192.168.1.237", "192.168.1.98"])#pi 3b+ ip
C = pistack.comms.Comms("/dev/ttyUSB0", 9600)
#C = pistack.comms.Comms("/dev/ttyUSB1", 9600)
stackList = [(9, 1),(9, 0),(14, 1),(14, 0),(1, 1),(1, 0),(12, 1),(12, 0),(2, 1),(2, 0)]

def power_off(k):
    p = Popen(["ssh-keygen -R "+ipList[k]], stdin=PIPE, shell=True)
    p = Popen(["ssh -o StrictHostKeyChecking=no -i ssh-key-for-fruit root@" +ipList[k]+ " poweroff"], stdin=PIPE, shell=True)
    #print('waiting to shutdown before powering off '+str(k+1))
    time.sleep(0.1)
def kill_power(l):
    print("now killing power to "+str(l+1))
    C.pi_off(stackList[l][0],stackList[l][1])
    time.sleep(1)#this will run in the background

for i in range(10):
    power_off(i)
    print("sent power down via ssh, now waiting to execute")
print("going to sleep for 45 seconds")    
time.sleep(45)
print("woken up, sending kill switch to cut power.")
for j in range(10):
    print("sending power down sequence")
    #print(ipList[j])
    kill_power(j)
    time.sleep(2)
    print("sent kill power message via pistack")
    
