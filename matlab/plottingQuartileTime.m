clear all
close all
clc
% pi=["PI3B","PI3B+","ODROIDC2"];
pi=["ODROIDC2"];
    type=("baremetal");
    test=(["0K","1K","10K","100K"]);
%     test=(["0K"]);
% figure('units','normalized','outerposition',[0 0 1 1]);
meanTimeT=zeros(length(test),10);
lowerQuartT = zeros(length(test),10);
upperQuartT = zeros(length(test),10);
minTimeT= zeros(length(test),10);
maxTimeT= zeros(length(test),10);
for pidx = 1:length(pi)

    % figure(1);
    % hold on;
    % figure(2);
    % hold on;
    cpuMat = zeros(4,10);
    timMat = zeros(4,10);
    for idx = 1:length(test)
        [data0k,legendData] = getPiData4(10,5,test(idx),type,pi(pidx));
        time0k = getPiDataTime(10,5,test(idx),type,pi(pidx));
        for jidx = 1:10
            dataTest{jidx} = getTest(jidx+1,data0k,type);
        end
        for jidx = 1:10
            timeTest{jidx} = getTest(jidx+1,time0k,type);
        end
        [allTim,allCpuPointsFinal,~,totMeanCpu] = timeAverageLUQuart(dataTest,timeTest,test(idx),type,pi(pidx));
        [meanTime,lowerQuart,upperQuart,minTime,maxTime] = givingStatsForTime(allTim);
        meanTimeT(idx,:) = meanTime;
        lowerQuartT(idx,:) = lowerQuart; 
        upperQuartT(idx,:) = upperQuart;
        minTimeT(idx,:) = minTime;
        maxTimeT(idx,:) = maxTime;
    end
end

% [meanTime,lowerQuart,upperQuart,minTime,maxTime] = givingStatsForTime(allTim);
%figure('units','normalized','outerposition',[0 0 1 1]);
figure;
joeBoxPlot3d(meanTimeT,lowerQuartT,upperQuartT,minTimeT,maxTimeT,pi,type)
view([210.7 53])
zlim([0 1000])
print(gcf,('time' + pi(1)+'-' +type+ '.png' ),'-dpng','-r600'); 