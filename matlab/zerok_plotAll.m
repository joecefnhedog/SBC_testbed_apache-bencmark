clear all
close all
clc
%getPiData(i,j) i=number of pi's -- j=number of iterations
pi="PI3B";
type=("baremetal");
test=("100K");
mkdir(pi+"/"+type+"/"+test)

[data0k,legendData] = getPiData4(10,5,test,type,pi);
time0k = getPiDataTime(10,5,test,type,pi);

for i = 1:10
    dataTest{i} = getTest(i+1,data0k,type);
end

for i = 1:10
    timeTest{i} = getTest(i+1,time0k,type);
end
plotCpuNginxSurfAB(dataTest,timeTest,test,type,pi);
totMeanCpu = plotCpuNginxAverage(dataTest,timeTest,test,type,pi);
% % %abi-j    i = pi, j = iteration
% ab = getABData2(9,4,test,pi);
% plotSurf(4,9,ab,test,type)

%[nginxTimes,piStartTimes,totTime]=reference_test_times(test,type);
% figure
% hold on
% for idx = 1:10
%     plotCpuNginxBox(dataTest,timeTest,test,type,idx)
% end


plot_power_times(test,type,pi)


% figure('units','normalized','outerposition',[0 0 1 1]);
% hold on
% averageTests(dataTest,timeTest,test,type)




