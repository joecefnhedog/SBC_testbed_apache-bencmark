function [allTim,allCpuPointsFinal,maxTime,totMeanCpu] = plotCpuNginxAverageLUQuart(data,time,test,type,pi)

nPi=10;
n=5;
if type == "baremetal"
    pids=5;
elseif type == "docker"
    pids=2;
end

numberOfFiles= zeros(1,nPi);
for idx = 1:nPi
    numberOfFiles(idx) = n*pids*idx;
end


for idx = 1:10
%     idx;
    num = numberOfFiles(idx);
    [cpu,ram,tim] = convertData(data{idx},time{idx});
    cpuL = length(cpu);
    ramL = length(ram);
    timL = length(tim);
    
    if (cpuL == ramL) && (cpuL == timL)
    ('same size')
%     figure('units','normalized','outerposition',[0 0 1 1]);
%     hold on;
    count=0;
    %allCpuPoints=[0];
    %allCpuPoints = int16.empty(1,0);
    allCpuPoints = double.empty(1,0);
    for i = 1:timL
        count = count+1;
        tim1 =tim{i};
%         tim1(1)
%         tim2 = tim{i} - tim1(1)
        if (i <=(num/5)) 
            index=1;
        elseif (i <=((num/5)*2))
            index=2;
        elseif (i <=((num/n)*3))
            index=3;
        elseif (i <=((num/n)*4))
            index=4;
        elseif (i <=((num/n)*5))
            index=5;
        end
        
        
        if length(cpu{i}) == length(tim{i})
            %i
            %cpu{i}
            timArray = (tim{i});
            cpuArray = (cpu{i});
            
            newCpuArray = cpuArray(cpuArray ~=0);
            %newCpuArray = newCpuArray(newCpuArray ~=32767);
%             newCpuArray'
            allCpuPoints = [allCpuPoints,newCpuArray'];
            allCpuPoints(allCpuPoints>100)=[];
            %lowerQuart(1,i) = quantile(newCpuArray,0.25);
            %upperQuart(1,i) = quantile(newCpuArray,0.75)
            
            %maxArray(1,i) = max(newCpuArray);
            %minArray(1,i) = min(newCpuArray);
            meanCpu(1,i) = sum(newCpuArray)/length(newCpuArray);
            %meanCpu (1,i) = sum(cpu{i})/length(cpu{i});
            
            tend =(tim{i}- tim1(1));
            tend = tend(end);
            tendSum(i)=tend;
            %boxPlot3D(cpu{i})
            %figure;
            %boxplot(cpu{i})
            %plot3(ones(1,length(cpu{i}))*index,cpu{i},(tim{i}- tim1(1)));
        else
        end
        %plot(tim{i},ram{i})
        if length(ram{i}) == length(tim{i})
            %fill3(ones(1,length(cpu{i}))*index,100*ram{i},(tim{i}- tim1(1)), 'b', 'FaceAlpha', 1);
            %plot3(ones(1,length(cpu{i}))*index,100*ram{i},(tim{i}- tim1(1)));
        else
        end
    end
%     totMinArray{idx} = minArray;
%     totMaxArray{idx} = maxArray;
    totMeanCpu{idx} = meanCpu;
%     totLoweQua{idx} = lowerQuart;
%     totUppeQua{idx} = upperQuart;
    maxTime{idx} = sum(tendSum)/length(tendSum);
    allTim{idx} = timArray;
    allCpuPointsFinal{idx} = rmmissing(allCpuPoints);
%     view(-29,27)
%     xlabel("iteration")
%     ylabel("cpu usage %")
%     zlabel("time (S)")
%     set(gca,'FontSize',20)
%     saveas(gcf,"A_"+test+"_"+num2str(idx)+".png")
%     close
    else
        ('dataset size not consistent')
    end
%maxTime=cell2mat(maxTime);
end
end