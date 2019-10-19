# import os
# import time
# def update_priveleges():
#     #os.system("chmod -R 777 /var/lib/nginx")                                   
#     #os.system("chmod -R 777 /www")                                             
#     #os.system("chown -R www:www /var/lib/nginx")
#     #os.system("chown -R www:www /www")
#     os.system("adduser -D -g \'www\' www")
#     # path = "/tmp/foo"  
#     # for root, dirs, files in os.walk(path):  
#     #     for momo in dirs:  
#     #         os.chown(os.path.join(root, momo), www, www)
#     #     for momo in files:
#     #         os.chown(os.path.join(root, momo), www, www)
#     print("fin")
# update_priveleges()


 
import os
import time
def chownpython(path):
    for root, dirs, files in os.walk(path):
        for momo in dirs:
            os.chown(os.path.join(root, momo), 1000, 1000)
        for momo in files:
            os.chown(os.path.join(root, momo), 1000, 1000)


def update_priveleges():
    os.system("apk update")
    os.system("apk add nginx")
    os.system("adduser -D -g 'www' www")
    os.system("mkdir /www")
    os.system("rm /var/lib/nginx/run")
    path1 = "/var/lib/nginx"
    chownpython(path1)
    path2 = "/www"
    chownpython(path2)
    print("fin")
update_priveleges()
