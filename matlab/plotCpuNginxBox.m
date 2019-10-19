function plotCpuNginxBox(data,time,test,type,piTest)
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


for idx = piTest:piTest
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
    for i = 2:2%timL
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
            %meanCpu(i,index)=sum(cpu{i})/length(cpu{i})
            %boxPlot3D(cpu{i})
            %cdfplot(cpu{i})
            boxplot(cpu{i})
%             ylim([0 60])
%             saveas(gcf,type+"/"+test+"/box_"+test+"_"+type+num2str(piTest)+num2str(idx)+".png")
%             close
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
%     view(-29,27)
%     xlabel("iteration")
%     ylabel("cpu usage %")
%     zlabel("time (S)")
%     set(gca,'FontSize',20)

    else
        ('dataset size not consistent')
    end
end
end