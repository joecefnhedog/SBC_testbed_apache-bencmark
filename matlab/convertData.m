function [cpu,ram,time99] = convertData(data,time)
tot= length(data);%for test1 there are 5 'pid' and 10 iterations
for i = 1 : tot
    %i;
    
    T=(data{1,i});
    [is,js] = size(T);
%     is
%     js
%     [is,js]=size(T);
    if ((is==1) && (js==1))
        %"only one data point"
        b = [0,0];
    else
        %T=fillmissing(T,'constant',0,'DataVariables',@isnumeric)
        b=table2array(T(:,2:3));
        %whos table2array(T(:,2:3))
    end
    [Y, M, D, H, M, S] = datevec(char(time{1,i}),'HH:MM:SS.FFF');%the milliseconds get added to the seconds 'S'
    %[Y, M, D, H, M, S] = datevec(char(time{1,i}),'HH:MM:SS');%the milliseconds get added to the seconds 'S'
    S = S + (60*M) + (3600*H);
    cpu{i} = b(:,1);
    ram{i} = b(:,2);
    time99{i} = S;
end    
end
