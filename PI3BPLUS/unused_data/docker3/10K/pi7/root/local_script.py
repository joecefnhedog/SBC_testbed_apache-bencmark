import socket
import sys
import threading
import subprocess
import sched
import time
import os
import signal
from subprocess import check_output
sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
sock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
#server_socket = ('192.168.1.138', 5000)
server_socket = ((sys.argv[1]), 5000)

sock.bind(server_socket)


process = None
currentData = ',,'
sleepT = 1;#measurement will affect the experiment, too much load on the cpu

  
def run_command(i,j):
    global process
    #find process id's of anything running nginx
    pids = subprocess.check_output(['pidof', 'nginx'])
    processes = pids.split()
    for p in range(len(processes)):
        process = (subprocess.Popen('(top -b -n 1 | grep '+str(processes[p])+' | head -1 | awk \'{print $1 " " $7 " " $8 " " $9}\') >> '+str(processes[p])+'htop-i'+str(i) +'PI'+str(j) +'.txt',shell=True))
        process = (subprocess.Popen('date +\"%T.%3N\" >> ' +str(processes[p])+'time'+str(i) +'PI'+str(j)+'.txt',shell=True))
    #time.sleep(sleepT)
    return process
def get_data():
    global currentData
    while True:
        data, address = sock.recvfrom(1024)
        currentData = data
def run():
    while True:
        AllData = currentData.split(",")
        iteration = AllData[2]
        iterationj = AllData[1]
        data = AllData[0]
        #print(data)
        if data == '1':
            run_command(iteration,iterationj)
            time.sleep(1)
            process.kill()
        if data == '2':
            process.kill()
            subprocess.Popen('pkill python', shell=True)
        if data == '3':
            subprocess.Popen('rc-service nginx stop',shell=True)
            print('nginx stopped final on pi1')
            print("Closing program")
            subprocess.Popen('pkill python', shell=True)
            exit()

#add_nginx()
runThread = threading.Thread(target = run)
runThread.start()
get_DataThread = threading.Thread(target = get_data)
get_DataThread.start()
print('starting listening thread')
