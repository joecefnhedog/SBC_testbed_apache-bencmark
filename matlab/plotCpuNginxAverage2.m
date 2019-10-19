function totMeanCpu = plotCpuNginxAverage2(data,time,test,type)
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

count=0;
for idx = 1:10
%     idx;
    num = numberOfFiles(idx);
    [cpu,ram,tim] = convertData(data{idx},time{idx});
    cpuL = length(cpu)
    ramL = length(ram);
    timL = length(tim);
    
    if (cpuL == ramL) && (cpuL == timL)
    ('same size')
%     figure('units','normalized','outerposition',[0 0 1 1]);
%     hold on;
    %count=0;
    for i = 1:timL
%         count = 0;
        timL
%         count = count+1;
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
            mCpu = (cpu{i});
%             count=count+1;
%             for cidx = 1:length(cpu{i})
%                 foo(count) = cpu{i};
%             end
                
            
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
    totMeanCpu{idx} = mCpu;
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
end
end