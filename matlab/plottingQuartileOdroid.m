clear all
close all
clc
% pi=["PI3B","PI3B+"];
pi=["ODROIDC2"];
    type=("docker");
    test=(["0K","1K","10K","100K"]);
%     test=(["0K"]);
figure('units','normalized','outerposition',[0 0 1 1]);    
for pidx = 1:length(pi)
    % figure(1);
    % hold on;
    % figure(2);
    % hold on;
    cpuMat = zeros(4,10);
    timMat = zeros(4,10);
    for idx = 1:length(test)
    %     mkdir(type+"/"+test)
        [data0k,legendData] = getOdroidData(10,5,test(idx),type,pi(pidx));
        time0k = getOdroidDataTime(10,5,test(idx),type,pi(pidx));
        for jidx = 1:10
            dataTest{jidx} = getTest(jidx+1,data0k,type);
        end
        for jidx = 1:10
            timeTest{jidx} = getTest(jidx+1,time0k,type);
        end
        [allTim,allCpuPointsFinal,maxTime,totMeanCpu] = plotCpuNginxAverageLUQuart(dataTest,timeTest,test(idx),type,pi(pidx));
%         [allTim,allCpuPointsFinal,maxTime,totMeanCpu] = timeAverageLUQuart(dataTest,timeTest,test(idx),type,pi(pidx));
        maxTime=cell2mat(maxTime);
        for idx2 = 1:10
            %allCpuPointsFinal{idx2} = 
            meanCpu(idx2) = mean(allCpuPointsFinal{idx2});
            lqCpu(idx2) = quantile((allCpuPointsFinal{idx2}),0.25);
            uqCpu(idx2) = quantile((allCpuPointsFinal{idx2}),0.75);
            maxVal(idx2)= max(allCpuPointsFinal{idx2});
            minVal(idx2)= min(allCpuPointsFinal{idx2});
            ((totMeanCpu{idx2}));
            A = totMeanCpu{idx2};
            B = rmmissing(A);
            AvCpu(idx2) = sum(B)/((length(B)));
            index(idx2) = idx;
        end
%         cpuMat(idx,:)= AvCpu;
        timMat(idx,:)= maxTime;
        meanCpuMat(idx,:)=meanCpu;
        meanLquMat(idx,:)=lqCpu;
        meanUquMat(idx,:)=uqCpu;
        meanMinMat(idx,:)=minVal;
        meanMaxMAt(idx,:)=maxVal;        
    %     averageTests(dataTest,timeTest,test(idx),type,idx)
    end
%     joeBoxPlot3d(meanCpuMat,meanLquMat,meanUquMat,meanMinMat,meanMaxMAt)



%%     subplot(2,2,pidx+2)
%     subplot(1,2,pidx)
%     bar3(timMat')
%     xlabel('data file')
%     xticks([1 2 3 4])
%     xticklabels({'0k','1k','10k','100k'})
%     ylabel('number of pis running the test.')
%     zlabel('time taken for AB test')
%     title(pi(pidx)+' '+type)
%     zlim([0 1000])
%  title(pi(pidx)+' '+type)
end
% saveas(gcf,"3dTimCpu.png")

joeBoxPlot3d(meanCpuMat,meanLquMat,meanUquMat,meanMinMat,meanMaxMAt,pi(pidx),type)




