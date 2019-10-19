function plotCpuNginx(cpu,ram,tim)
cpuL = length(cpu);
ramL = length(ram);
timL = length(tim);
if (cpuL == ramL) && (cpuL == timL)
    ('same size')
    figure;
    hold on;
    for i = 1:timL
        if length(cpu{i}) == length(tim{i})
            plot3(tim{i},cpu{i},ones(1,length(cpu{i}))*i);
        else
        end
        %plot(tim{i},ram{i})
        if length(ram{i}) == length(tim{i})
            plot3(tim{i},100*ram{i},ones(1,length(cpu{i}))*i);
        else
        end
    end
    view(-29,27)
else
    ('dataset size not consistent')
end
end