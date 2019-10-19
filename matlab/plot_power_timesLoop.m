function plot_power_timesLoop(test,type,pi)
[nginxTimes,piStartTimes]=reference_test_times(test,type);
nPi=10
n=5
y = [50 -0.5]
[v1,v2,t1]=voltage_data(test,type);
averV2 = movmean(v2,40);
figure('units','normalized','outerposition',[0 0 1 1]);
hold on;plot(t1,(averV2)/0.0412);plot(t1,v1.*(averV2/0.0412),'--b')



% for idx = 1:nPi
%     x2 = [piStartTimes(idx) piStartTimes(idx)];
%     line(x2,y,'Color','red','LineStyle','--')
%     for jdx = 1:n
%         x = [nginxTimes(idx,jdx) nginxTimes(idx,jdx)];
%         line(x,y)
%     end
% end

% saveas(gcf,pi+"/"+type+"/"+test+"/power"+".png")
% pause(5)
% close


end