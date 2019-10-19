function joeBoxPlot3d(cpu,lq,uq,min,max,pi,type)
% close all
% clear all
rgb = colormap;
% cpu = [20.9163701067616,22.3813291139241,21.9360146252285,22.0077279752705,22.6150234741784,20.0383561643836,20.5073170731707,20.9192982456140,20.2197414806110,22.0097719869707;20.2793053545586,20.8111782477341,20.3220088626292,21.6450151057402,20.5193905817175,19.3810198300283,20.1813664596273,20.8427464008859,21.6461388074291,21.7390882638215;15.5718750000000,18.3621262458472,19.5652582159624,20.2019138755981,20.7956131605184,20.3352657004831,19.0093023255814,17.7344129554656,17.8803358992302,20.3247524752475;9.17577639751553,12.3972141091889,14.0078764010906,13.6363636363636,13.9516765285996,13.9967018469657,14.2247829991021,12.7257972665148,12.2422827496757,11.7992941176471];
% lq = [11,11,11,10,10,12,11,10,10,10;11,11,11,10,10,10,10,10,10,10;6,6,6,9,9,9,6,6,6,6;5,5,10,10,11,11,10,10,10,6];
% uq = [28,31,32,30,35,26,30,32,29,35;28,29,27,32,29,26,29,32,33,33;25,32,33,35,35,35,33,30,30,35;11,16,17,17,17,16,17,16,16,16];
% min = [3,4,3,4,3,3,4,4,3,4;3,4,3,3,4,2,4,4,4,3;3,3,3,3,3,2,2,4,3,3;3,3,3,3,2,3,3,3,3,3];
% max = [65,63,60,61,61,55,56,61,74,61;58,58,64,61,57,61,75,58,61,67;55,53,58,56,53,53,55,50,53,70;50,100,44,50,44,58,42,37,37,47];

lq = double(lq);
uq = double(uq);
min = double(min);
max = double(max);





hold on
 
% plot3(P(1),P(2),P(3),'*k')
% plot3(P(1),P(2),P(3),'*k')
xlen=0.3;
ylen=0.5;
zlen=0.5;


for i = 1:10
    for j = 1:4


%         Pmx = [j,i,max(j,i)] ;   % you center point 
%         Lmx = [.05,.05,.05] ;  % your cube dimensions 
%         Omx = Pmx-Lmx/2 ;       % Get the origin of cube so that P is at center 
%         plotcube(Lmx,Omx,.8,[1 0 0]);   % use function plotcube

        Pu = [j,i,uq(j,i)] ;   % you center point
        Lu = [xlen,ylen,zlen] ;  % your mean -cube dimensions
        Ou = Pu-Lu/2 ;       % Get the origin of cube so that P is at center 
        plotcube(Lu,Ou,.2,[rgb(i*7 -6,1) rgb(i*7-6,2) rgb(i*7-6,3)]);   % use function plotcube


        Pm = [j,i,cpu(j,i)] ;   % you center point
        Lm = [xlen,ylen,zlen] ;  % your mean -cube dimensions
        Om = Pm-Lm/2 ;       % Get the origin of cube so that P is at center 
        plotcube(Lm,Om,.2,[rgb(i*7 -6,1) rgb(i*7-6,2) rgb(i*7-6,3)]);   % use function plotcube

% 
        Pl = [j,i,lq(j,i)] ;   % you center point 
        Ll = [xlen,ylen,zlen] ;  % your cube dimensions 
        Ol = Pl-Ll/2 ;       % Get the origin of cube so that P is at center 
        plotcube(Ll,Ol,.2,[rgb(i*7 -6,1) rgb(i*7-6,2) rgb(i*7-6,3)]);   % use function plotcube
        
        
        
        Pq = [j,i,(uq(j,i)+lq(j,i))/2] ;   % you center point 
        Lq = [xlen,ylen,(uq(j,i)-lq(j,i))] ;  % your cube dimensions 
        Oq = Pq-Lq/2 ;       % Get the origin of cube so that P is at center 
        plotcube(Lq,Oq,.2,[rgb(i*7 -6,1) rgb(i*7-6,2) rgb(i*7-6,3)]);   % use function plotcube
        
        p1 = [j,i,min(j,i)];
        p2 = [j,i,max(j,i)];
        pts=[p1;p2];
        plot3(pts(:,1), pts(:,2), pts(:,3),'r-*')
        
%         Pmn = [j,i,min(j,i)] ;   % you center point 
%         Lmn = [.05,.05,.05] ;  % your cube dimensions 
%         Omn = Pmn-Lmn/2 ;       % Get the origin of cube so that P is at center 
%         plotcube(Lmn,Omn,.8,[1 0 0]);   % use function plotcube

    end
end



view([48.9500 49.9075])
xlabel('Data File.')
xticks([1 2 3 4])
xticklabels({'0k','1k','10k','100k'})
ylabel('Number of pis running the test.')
yticks([1 2 3 4 5 6 7 8 9 10])
yticklabels({'1','2','3','4','5','6','7','8','9','10'})

zlabel('Time (s).')
%zlabel('Cpu Usage.')
title(pi+' '+type)

grid





