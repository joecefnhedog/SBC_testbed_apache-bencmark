function AvCpu = averageTests(data,time,test,type,index3d)
[allCpuPointsFinal,maxTime,totMeanCpu] = plotCpuNginxAverage(data,time,test,type)
maxTime=cell2mat(maxTime);
for idx = 1:10
    ((totMeanCpu{idx}));
    A = totMeanCpu{idx};
    B = rmmissing(A);
    AvCpu(idx) = sum(B)/((length(B)));
    index(idx) = idx;
end
% figure('units','normalized','outerposition',[0 0 1 1]);
% hold on;
figure(1);
hold on
plot3(index,AvCpu,index3d*ones(length(index)))
xlabel("number of pis running the apacheBench test")
ylabel("average cpu usage(averaging across iterations, and each pi)")
figure(2);
hold on
plot(index,maxTime)
xlabel("number of pis running the apacheBench test")
ylabel("average total time")
ylimit([0 25])

% title(test+" "+type)
% saveas(gcf,type+"/"+test+"/av_cpu_"+"_"+".png")
% close