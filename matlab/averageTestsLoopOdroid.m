% clear all
% close all
% clc
% 
% pi="ODROIDC2";
% type=("baremetal");
% test=("0K");
% [data0k,legendData] = getOdroidData(10,5,test,type,pi);
% time0k = getOdroidDataTime(10,5,test,type,pi);
% for jidx = 1:10
%     dataTest{jidx} = getTest(jidx+1,data0k,type);
% end
% 
% for jidx = 1:10
%     timeTest{jidx} = getTest(jidx+1,time0k,type);
% end
% [allCpuPointsFinal,maxTime,totMeanCpu] = plotCpuNginxAverage(dataTest,timeTest,test,type);

clear all
close all
clc
pi=["ODROIDC2"];
    type=("baremetal");
    test=(["0K","1K","10K","100K"]);
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
        [allCpuPointsFinal,maxTime,totMeanCpu] = plotCpuNginxAverage(dataTest,timeTest,test(idx),type);
        maxTime=cell2mat(maxTime);
        for idx2 = 1:10
            ((totMeanCpu{idx2}));
            A = totMeanCpu{idx2};
            B = rmmissing(A);
            AvCpu(idx2) = sum(B)/((length(B)));
            index(idx2) = idx;
        end
        cpuMat(idx,:)= AvCpu;
        timMat(idx,:)= maxTime;
    %     averageTests(dataTest,timeTest,test(idx),type,idx)
    end


    
%     subplot(1,2,pidx)
%     bar3(cpuMat)
%     xlabel('number of pis running the test.')
%     yticks([1 2 3 4])
%     yticklabels({'0k','1k','10k','100k'})
%     ylabel('datafile')
%     zlabel('average cpu usage')
%     %view([60 30])
%     zlim([5 25])
%     title(pi(pidx)+' '+type)


%%     subplot(2,2,pidx+2)
    subplot(1,2,pidx)
    bar3(timMat')
    xlabel('data file')
    xticks([1 2 3 4])
    xticklabels({'100k','1k','10k','100k'})
    ylabel('number of pis running the test.')
    zlabel('time taken for AB test')
    title(pi(pidx)+' '+type)
%     zlim([0 1000])
 title(pi(pidx)+' '+type)
end
saveas(gcf,"3dTimCpu.png")
%zlim([8 25])



% close
% figure(1)
% legend('0k','1k','10k','100k')
% figure(2)
% legend('0k','1k','10k','100k')



% [cpu,ram,tim] = convertData(dataTest{1},timeTest{1});
% boxplot(vertcat(cpu{:}))






% 
% 
% pi="PI3B+";
% type=("baremetal");
% test=("0K");
% [data0k,legendData] = getPiData4(10,5,test,type,pi);
% time0k = getPiDataTime(10,5,test,type,pi);
% for jidx = 1:10
%     dataTest{jidx} = getTest(jidx+1,data0k,type);
% end
% for jidx = 1:10
%     timeTest{jidx} = getTest(jidx+1,time0k,type);
% end
% [allCpuPoints,maxTime,totMeanCpu] = plotCpuNginxAverage(dataTest,timeTest,test,type,pi);
% group = [ones(size(allCpuPoints{1}'))*1;
%         ones(size(allCpuPoints{2}'))*2;
%         ones(size(allCpuPoints{3}'))*3;
%         ones(size(allCpuPoints{4}'))*4;
%         ones(size(allCpuPoints{5}'))*5;
%         ones(size(allCpuPoints{6}'))*6;
%         ones(size(allCpuPoints{7}'))*7;
%         ones(size(allCpuPoints{8}'))*8;
%         ones(size(allCpuPoints{9}'))*9;
%         ones(size(allCpuPoints{10}'))*10];
% figure('units','normalized','outerposition',[0 0 1 1]);
% boxplot([allCpuPoints{1}';allCpuPoints{2}';allCpuPoints{3}';allCpuPoints{4}';allCpuPoints{5}';allCpuPoints{6}';allCpuPoints{7}';allCpuPoints{8}';allCpuPoints{9}';allCpuPoints{10}'],group)
% ylim([0 100])
% saveas(gcf,pi+"/"+type+"/"+test+"/box"+".png")
% close






