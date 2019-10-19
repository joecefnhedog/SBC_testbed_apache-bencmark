function plotCpuNginxMultiple(data,time)
nPi=10;
n=5;
pids=5;
numberOfFiles= zeros(1,nPi);
for idx = 1:nPi
    numberOfFiles(idx) = n*pids*idx;
end

% for tidx = 1:num
%     if (tidx <=(num/5)) 
%         index=1;
%     elseif (tidx <=((num/5)*2))
%         index=2;
%     elseif (tidx <=((num/n)*3))
%         index=3;
%     elseif (tidx <=((num/n)*4))
%         index=4;
%     elseif (tidx <=((num/n)*5))
%         index=5;
%     end
% end

for idx = 1:10
    num = numberOfFiles(idx);
    [cpu,ram,tim] = convertData(data{idx},time{idx});
    cpuL = length(cpu);
    ramL = length(ram);
    timL = length(tim);
    
    if (cpuL == ramL) && (cpuL == timL)
    ('same size')
    figure('units','normalized','outerposition',[0 0 1 1]);
    hold on;
    for i = 1:timL
        cpu{i,i}
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
            plot3(ones(1,length(cpu{i}))*index,cpu{i},tim{i});
        else
        end
        %plot(tim{i},ram{i})
        if length(ram{i}) == length(tim{i})
            plot3(ones(1,length(cpu{i}))*index,100*ram{i},tim{i});
        else
        end
    end
    view(-29,27)
    xlabel("time (S)")
    ylabel("cpu usage %")
    zlabel(" ")
    set(gca,'FontSize',20)
%     saveas(gcf,"A_"+num2str(idx)+".png")
%     close
    else
        ('dataset size not consistent')
    end
end