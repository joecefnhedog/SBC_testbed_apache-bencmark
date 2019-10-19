import os
import time
import sys
import pwd
import grp
import os
def update_packages():
     os.system("apk update")
     time.sleep(15)
     os.system("apk add htop")
     time.sleep(15)
     os.system("apk add --update coreutils")#needed to use the date command
     time.sleep(15)
     os.system("apk add procps")#needed to monitor top time
     time.sleep(15)
     os.system("apk add python")
     time.sleep(25)
     os.system("apk add nginx")
     time.sleep(15)
     #os.system("apk add emacs")
     time.sleep(95)
     print("fin1")
update_packages()
