import os
import time
picoStart = time.time()
n=1
nPi=1
testTime = ([300*n*(nPi),350*n*nPi])
ab=0
def testTimeSum(ab_idx):
    tt=0
    for idx in range(ab_idx+1):
        tt+=testTime[idx]
        #print (str(tt))
    return tt


print (str(testTimeSum(0)))
# while (time.time()-picoStart)<(testTime[ab]):
#     print "pico is still loggging, wait until" + str(time.time()-picoStart) +">"+str(testTimeSum(ab))
#     time.sleep(10)
# print "pico stopped logging, waiting until files were saved:"
# time.sleep(10)
