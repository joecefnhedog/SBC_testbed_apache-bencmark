function [cpu,ram,time99] = convertData2(data,time)
tot= length(data);%for test1 there are 5 'pid' and 10 iterations
for i = 1 : tot
    %T=(data(1,i));
    f1 = table2array(data(i));
    f2 = f1(:,2:3);
    %b=table2array(T(:,2:3));
    [Y, M, D, H, M, S] = datevec(char(table2array(time(1,i))),'HH:MM:SS.FFF');%the milliseconds get added to the seconds 'S'
    S = S + (60*M) + (360*H);
    cpu{i} = f2(:,1);
    ram{i} = f2(:,2);
    time99{i} = S;
end
%cpu=table2array(cpu);
%ram=table2array(ram);
end