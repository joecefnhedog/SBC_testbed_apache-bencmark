clear all
close all
clc
pi="PI3B";
type=("baremetal");
test=(["0K","1K","10K","100K"]);
col=['b','g','r','c'];
gap = 100;%gap between power points, otherwise the plot uses >8gb of ram
nPi=10;
n=5;
y = [50 -0.5];
% figure(1);
% hold on;
for idx = 1:length(test)
    [data0k,legendData] = getPiData4(10,5,test(idx),type,pi);
    time0k = getPiDataTime(10,5,test(idx),type,pi);
    [nginxTimes,piStartTimes]=reference_test_times(test(idx),type);
    for jidx = 1:10
        dataTest{jidx} = getTest(jidx+1,data0k,type);
    end

    for jidx = 1:10
        timeTest{jidx} = getTest(jidx+1,time0k,type);
    end
    
    [v1,v2,t1]=voltage_data(test(idx),type);
    averV2 = movmean(v2,40);
    plot3(t1(1:gap:end),v1(1:gap:end).*(v2(1:gap:end)),idx*ones(length(t1(1:gap:end))),col(idx));
    hold on;
end

pause(5)


% figure(1)
%legend('0k','1k','10k','100k')
% view(-29,27)
% figure(2)
% legend('0k','1k','10k','100k')
% saveas(gcf,pi+"/"+type+"/power"+".png")
% close all
% clear all





