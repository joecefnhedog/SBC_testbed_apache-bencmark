clear all
close all
clc
nPi=5;
n=10;
numfiles = nPi*n;
%filedata = cell(1,numfiles);
count=0;
for i = 0:(nPi-1)
    for j = 0:(n-1)
        count=count+1;
        %filename = sprintf('/home/joseph/Dropbox/rpi_testbed/0k-1stpi/htop-i%dPI%d.txt',i,j);
        filename = sprintf('/home/joseph/Dropbox/rpi_testbed/0k_5_data/data1/htop-i%dPI%d.txt',i,j);

        filedata{count} = readtable(filename);
        T{count} = sortrows(table2array(filedata(count)),[1 4]);
    end
end
T1 = T{1};
T1 = T1(:,4);
Time = table2cell(T1);
T1 = char(Time);
[Y, M, D, H, M, S] = datevec(T1,'MM:SS.FFF');%the milliseconds get added to the seconds 'S'
% [Y,M,D,H,M,S] = datevec(T2,'MM:SS.FFF');%the milliseconds get added to the seconds 'S'
% % T = readtable(filename);
% % T = sortrows(T,[1 4]);%sort rows by the first colum, then 4th to keep time ordered.
% % A = table2array(T(:,1:3));
% % 
% % T = T(:,4);
% % Time = table2cell(T);
% % T2 = char(Time);
% % [Y, M, D, H, M, S] = datevec(T2,'MM:SS.FFF');%the milliseconds get added to the seconds 'S'
% % S=S+(60*M);