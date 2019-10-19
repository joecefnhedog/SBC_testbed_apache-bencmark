clear all
close all
clc
nPi=10;
n=1;
%numfiles = nPi*n;
count=0;
delimiterIn = ' ';
for i = 0:(nPi-1)
    for j = 0:(n-1)
        count=count+1;
        filename = sprintf('/home/joseph/Dropbox/rpi_testbed/test2/2146time%dPI%d.txt',i,j);
        %filedata{count} = readtable(filename);        
        filedata{count} = importdata(filename,delimiterIn);
    end
end

Time = (filedata{1});
T2 = char(Time);
[Y, M2, D, H, M, S] = datevec(T2);%the milliseconds get added to the seconds 'S'

tCur = S + (M*60) + (H*360) ;
tCur = tCur - tCur(1);


count=0;
for i2 = 0:(nPi-1)
    for j2 = 0:(n-1)
        count=count+1;
        filename2 = sprintf('/home/joseph/Dropbox/rpi_testbed/test2/2146htop-i%dPI%d.txt',i2,j2);
        filedata2{count} = readtable(filename2);
    end
end

A = filedata2{1};
A = table2array(A(:,1:3));
plot(tCur,A(:,2));


for i = 0:(nPi-1)
    for j = 0:(n-1)
        count=count+1;
        %filename = sprintf('/home/joseph/Dropbox/rpi_testbed/0k-1stpi/htop-i%dPI%d.txt',i,j);
        filename = sprintf('/home/joseph/Dropbox/rpi_testbed/ab/ab%d-%d.csv',i,j);

        %filedata{count} = readtable(filename);
        Mab(:,count) = csvread(filename,1,1);
    end
end

TP = csvread(filename,1,0);
TP = TP(:,1);
figure
plot(Mab(:,2)*(1.0000e-03),TP,'-o')
%line([Mab(end,1)*(1.0000e-03) Mab(end,1)*(1.0000e-03)], [0 100],'Color',[1 0 0]);

