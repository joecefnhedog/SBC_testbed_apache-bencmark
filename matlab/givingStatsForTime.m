function [meanTime,lowerQuart,upperQuart,minTime,maxTime] = givingStatsForTime(allTim)
meanTime=zeros(1,10);
lowerQuart=zeros(1,10);
upperQuart=zeros(1,10);
minTime=zeros(1,10);
maxTime=zeros(1,10);

for i = 1:10
    t1 = (allTim{i});
    t1=t1(1);
    time1 = allTim{i}-t1;
    time1inv = -1*time1;
    [val,~]=findpeaks(time1);
    [valm,~]=findpeaks(time1inv);
    valm=valm*-1;
    totTimes = val-valm;
    meanTime(i) = mean(totTimes);
    lowerQuart(i) = quantile(totTimes,0.25);
    upperQuart(i) = quantile(totTimes,0.75);
    minTime(i) = min(totTimes);
    maxTime(i) = max(totTimes);
end