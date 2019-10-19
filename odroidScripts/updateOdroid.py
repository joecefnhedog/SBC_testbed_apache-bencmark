import subprocess
import os
import time
from subprocess import Popen, PIPE
ipList = (["192.168.1.200","192.168.1.33"])#odroid c2 ip

def update(u):
    p = Popen(["sshpass -p odroid ssh odroid@" +ipList[u]+" 'sudo apt-get update -y'"], stdin=PIPE, shell=True)
    time.sleep(5)
    p = Popen(["sshpass -p odroid ssh odroid@" +ipList[u]+" 'sudo apt-get upgrade -y'"], stdin=PIPE, shell=True)
    time.sleep(5)

for idx in range(len(ipList)):
    update(idx)
    time.sleep(20)
