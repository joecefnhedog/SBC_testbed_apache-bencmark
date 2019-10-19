import os
def add_data_files():
     os.system("dd if=/dev/zero of=/www/0K.dat count=1 bs=1")
     os.system("dd if=/dev/zero of=/www/1K.dat count=1024 bs=1")
     os.system("dd if=/dev/zero of=/www/10K.dat count=1024 bs=10")
     os.system("dd if=/dev/zero of=/www/100K.dat count=1024 bs=100")
     print("wedi gorfen")
add_data_files()
