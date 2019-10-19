from picoscope import ps3000a
import pylab as plt
import numpy as np
import time
import pandas as pd
import sys

start_time1 = time.time()
print("Attempting to open Picoscope 3000...")
ps = ps3000a.PS3000a()
smooth=20
timeT=int(sys.argv[1])
def movingaverage(interval, window_size):
    window= np.ones(int(window_size))/float(window_size)
    return np.convolve(interval, window, 'same')

waveform_desired_duration = 1
obs_duration = timeT * waveform_desired_duration
sampling_interval = obs_duration / (10*timeT)

(actualSamplingInterval, nSamples, maxSamples) = \
    ps.setSamplingInterval(sampling_interval, obs_duration)
print("Sampling interval = %f ns" % (actualSamplingInterval * 1E9))
print("Taking  samples = %d" % nSamples)
print("Maximum samples = %d" % maxSamples)
start_time = time.time()
# the setChannel command will chose the next largest amplitude
channelRangeA = ps.setChannel('A', 'DC',20)
print("Chosen channel range = %d" % channelRangeA)
channelRangeB = ps.setChannel('B', 'DC',0.1)
print("Chosen channel range = %d" % channelRangeB)
#ps.setSimpleTrigger('A', 1.0, 'Falling', timeout_ms=100, enabled=True)
#ps.setSimpleTrigger('B', 1.0, 'Falling', timeout_ms=100, enabled=True)
#ps.setSigGenBuiltInSimple(offsetVoltage=0, pkToPk=1.2, waveType="Sine",
#                          frequency=50E3)

#ps.runBlock()
#ps.waitReady()

#print("Waiting for awg to settle.")
#time.sleep(2.0)
ps.runBlock()
ps.waitReady()
print("Done waiting for trigger")
dataA = ps.getDataV('A', nSamples, returnOverflow=False)
dataB = ps.getDataV('B', nSamples, returnOverflow=False)
print(type(dataA))
#smoothA = pd.rolling_mean(dataA,100)
#smoothA = dataA.rolling(100).mean()
#smoothA =moving_average(dataA, n=40)
smoothA = movingaverage(dataA,smooth)
#smoothB = pd.rolling_mean(dataB,100)
#smoothB = dataB.rolling(100).mean()
#smoothB =moving_average(dataB, n=40)
smoothB = movingaverage(dataB,smooth)
dataTimeAxis = np.arange(nSamples) * actualSamplingInterval

ps.stop()
ps.close()
timeStop = time.time() - start_time
print("--- %s seconds ---" % (timeStop))
    # Uncomment following for call to .show() to not block
    # plt.ion()

#plt.figure()
##plt.hold(True)
#plt.plot(dataTimeAxis, smoothA, label="Clock")
#plt.grid(True, which='major')
#plt.title("Picoscope 2000 waveforms")
#plt.ylabel("Voltage (V)")
#plt.xlabel("Time (S)")
#plt.ylim([16,20])
##plt.set_ylim([ymin,ymax])
#plt.legend()
#plt.show()

#plt.figure()
##plt.hold(True)
#plt.plot(dataTimeAxis, (smoothB/0.0412), label="Clock")
#plt.grid(True, which='major')
#plt.title("Picoscope 2000 waveforms")
#plt.ylabel("Current (A)")
#plt.xlabel("Time (S)")
#plt.ylim([-1.0,4])
#plt.legend()
#plt.show()
print(len(dataTimeAxis))
print(len(smoothA))
print(len(dataA))

current = (smoothB/0.0412)
power   = ((smoothA)*(smoothB/0.0412))
# fig, ax1 = plt.subplots()

# #color = 'tab:red'
# ax1.set_xlabel('time (s)')
# ax1.set_ylabel('Voltage (V)')
# ax1.plot(dataTimeAxis, smoothA, color='red')
# ax1.tick_params(axis='y')
# ax1.set_ylim([17,18])
# #ax1.axvline(30, color='k', linestyle='--')

# ax2 = ax1.twinx()  # instantiate a second axes that shares the same x-axis

# #color = 'tab:blue'
# ax2.set_ylabel('Current (I)')  # we already handled the x-label with ax1
# ax2.plot(dataTimeAxis,  current, color='blue')
# ax2.tick_params(axis='y')
# #ax2.set_ylim([0,2])
# fig.tight_layout()  # otherwise the right y-label is slightly clipped
# plt.show()

# plt.figure()
# ##plt.hold(True)
# plt.plot(dataTimeAxis,  power)
# plt.grid(True, which='major')
# plt.title("")
# plt.ylabel("Power (W)")
# plt.xlabel("Time (S)")
# #plt.ylim([-1.0,4])
# plt.legend()
# #plt.axvline(30, color='k', linestyle='--')
# plt.show()
# print(type(power))
# print(power.size)

import csv
import os
# Create directory
#dirName = 'picoData'
#if not os.path.exists(dirName):
#    os.mkdir(dirName)
#    print("Directory " , dirName ,  " Created ")
#else:    
#    print("Directory " , dirName ,  " already exists")

with open('ab/voltage1-'+str(timeT)+'.csv', 'w+', newline='') as csvfile:
    writer = csv.writer(csvfile, delimiter=',')
    for row in range(0,dataA.shape[0]):
        myList = []
        myList.append(dataA[row])
        writer.writerow(myList)

with open('ab/voltage2-'+str(timeT)+'.csv', 'w+', newline='') as csvfile:
    writer = csv.writer(csvfile, delimiter=',')
    for row in range(0,dataB.shape[0]):
        myList = []
        myList.append(dataB[row])
        writer.writerow(myList)

with open('ab/time-'+str(timeT)+'.csv', 'w+', newline='') as csvfile:
    writer = csv.writer(csvfile, delimiter=',')
    for row in range(0,dataTimeAxis.shape[0]):
        myList = []
        myList.append(dataTimeAxis[row])
        writer.writerow(myList)

#for column in (power):
#    powerDat.write('%d;' % column)
#    powerDat.write('\n')
#powerDat.close()