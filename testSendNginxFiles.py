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
stackList = [(9, 1),(9, 0),(14, 1),(14, 0),(1, 1),(1, 0),(12, 1),(12, 0),(2, 1),(2, 0)]        
nPi = 1
clientList = [client() for count in xrange(nPi)]#pi clients
ipList = (["192.168.0.45"])


def update(u):
    p = Popen(["scp -o StrictHostKeyChecking=no -i ssh-key-for-fruit update_priveleges.py root@" +ipList[u]+":/root"], stdin=PIPE, shell=True)
    print("sent update_priveleges")
    time.sleep(2)
    p = Popen(["ssh -i ssh-key-for-fruit root@" +ipList[u]+" 'python3 update_priveleges.py'"], stdin=PIPE, shell=True)
    print ("executing update_priveleges")
    time.sleep(80)
    print("executed update priveleges")
    p = Popen(["scp -o StrictHostKeyChecking=no -i ssh-key-for-fruit nginx.conf root@" +ipList[u]+":/etc/nginx"], stdin=PIPE, shell=True)
    print("sent new nginx.conf file")
    time.sleep(2)
    p = Popen(["scp -o StrictHostKeyChecking=no -i ssh-key-for-fruit index.html root@" +ipList[u]+":/www"], stdin=PIPE, shell=True)
    print("sent new ondex.html")
    p = Popen(["scp -o StrictHostKeyChecking=no -i ssh-key-for-fruit nginx_files.py root@" +ipList[u]+":/www"], stdin=PIPE, shell=True)
    print("sent nginx_files to /www")
    p = Popen(["ssh -i ssh-key-for-fruit root@" +ipList[u]+" 'python3 /www/nginx_files.py'"], stdin=PIPE, shell=True)
    print("creating nginx data files")
    time.sleep(8)
    p = Popen(["ssh -i ssh-key-for-fruit root@" +ipList[u]+" 'rc-service nginx start'"], stdin=PIPE, shell=True)
    time.sleep(5)
    p = Popen(["ssh -i ssh-key-for-fruit root@" +ipList[u]+" 'nginx -t'"], stdin=PIPE, shell=True)
    time.sleep(5)
    p = Popen(["ssh -i ssh-key-for-fruit root@" +ipList[u]+" 'python3 update_priveleges.py'"], stdin=PIPE, shell=True)
    print ("executing update_priveleges again")
    time.sleep(20)
    p = Popen(["ssh -i ssh-key-for-fruit root@" +ipList[u]+" 'rc-service nginx restart'"], stdin=PIPE, shell=True)
    time.sleep(5)
    p = Popen(["ssh -i ssh-key-for-fruit root@" +ipList[u]+" 'nginx -t'"], stdin=PIPE, shell=True)
    time.sleep(5)
    

update(0)
print("1 2 3")
  
