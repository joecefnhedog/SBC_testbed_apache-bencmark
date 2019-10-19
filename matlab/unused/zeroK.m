clear all
% close all
clc

filename = '/home/joseph/Dropbox/rpi_testbed/0k_5_data/data1/htop-i0PI0.txt';
% A = load(filename);
T = readtable(filename);
T = sortrows(T,[1 4]);%sort rows by the first colum, then 4th to keep time ordered.
A = table2array(T(:,1:3));

T = T(:,4);
Time = table2cell(T);
T2 = char(Time);
[Y, M, D, H, M, S] = datevec(T2,'MM:SS.FFF');%the milliseconds get added to the seconds 'S'
S=S+(60*M);


[m,n] = size(A);
C = unique(A(:,1));%unique process numbers PID

a1 = sum(A(:) == C(1));
a2 = sum(A(:) == C(2));
a3 = sum(A(:) == C(3));
a4 = sum(A(:) == C(4));
a5 = sum(A(:) == C(5)); % 5 pids

A(:,3)=A(:,3)*100;
G = zeros(106,5);
A1 = A(1:a1,:);
A2 = A(a1+1:a1+a2,:);
A3 = A(a1+a2+1:a1+a2+a3,:);
A4 = A(a1+a2+a3+1:a1+a2+a3+a4,:);
A5 = A(a1+a2+a3+a4+1:a1+a2+a3+a4+a5,:);

S1 = S(1:a1,:);
S2 = S(a1+1:a1+a2,:);
S3 = S(a1+a2+1:a1+a2+a3,:);
S4 = S(a1+a2+a3+1:a1+a2+a3+a4,:);
S5 = S(a1+a2+a3+a4+1:a1+a2+a3+a4+a5,:);




% figure
% grid on;
% hold on
% % set(gca,'Color',[0.25, 0.25, 0.25])
% area(S2,A2(:,2),'FaceColor','k','FaceAlpha',sh1,'EdgeAlpha',sh2,'LineWidth',2.5)
% area(S2,A2(:,2),'FaceColor','b','FaceAlpha',sh1,'EdgeAlpha',sh2,'LineWidth',2.5)
% area(S3,A3(:,2),'FaceColor','r','FaceAlpha',sh1,'EdgeAlpha',sh2,'LineWidth',2.5)
% area(S4,A4(:,2),'FaceColor','g','FaceAlpha',sh1,'EdgeAlpha',sh2,'LineWidth',2.5)
% area(S5,A5(:,2),'FaceColor','y','FaceAlpha',sh1,'EdgeAlpha',sh2,'LineWidth',2.5)
% xlabel('CPU time - seconds (S)')
% ylabel('Percentage of CPU - 2 cores - 0-200%')
% legend({(num2str(C(1))),(num2str(C(2))),(num2str(C(3))),(num2str(C(4))),(num2str(C(5)))})
% hold off






sh1=0.1;
sh2=0.3;
figure

ax1 = subplot(2,1,1);
hold on
x = linspace(0,10,50);

area(S2,A2(:,2),'FaceColor','k','FaceAlpha',sh1,'EdgeAlpha',sh2,'LineWidth',2.5)
area(S2,A2(:,2),'FaceColor','b','FaceAlpha',sh1,'EdgeAlpha',sh2,'LineWidth',2.5)
area(S3,A3(:,2),'FaceColor','r','FaceAlpha',sh1,'EdgeAlpha',sh2,'LineWidth',2.5)
area(S4,A4(:,2),'FaceColor','g','FaceAlpha',sh1,'EdgeAlpha',sh2,'LineWidth',2.5)
area(S5,A5(:,2),'FaceColor','y','FaceAlpha',sh1,'EdgeAlpha',sh2,'LineWidth',2.5)
legend({(num2str(C(1))),(num2str(C(2))),(num2str(C(3))),(num2str(C(4))),(num2str(C(5)))})
xlabel('CPU time - seconds (S)')
ylabel('%CPU - 2 cores - 0-200%')
title(ax1,'CPU - baremetal - nginx - on Pi1 - 1 PI - 0K')
ylim([0 100])
% xlim([0 2.5])
ax1.FontSize = 14;
% ax1.XColor = 'red';

ax2 = subplot(2,1,2);
hold on
area(S2,A2(:,3),'FaceColor','k','FaceAlpha',sh1,'EdgeAlpha',sh2,'LineWidth',2.5)
area(S2,A2(:,3),'FaceColor','b','FaceAlpha',sh1,'EdgeAlpha',sh2,'LineWidth',2.5)
area(S3,A3(:,3),'FaceColor','r','FaceAlpha',sh1,'EdgeAlpha',sh2,'LineWidth',2.5)
area(S4,A4(:,3),'FaceColor','g','FaceAlpha',sh1,'EdgeAlpha',sh2,'LineWidth',2.5)
area(S5,A5(:,3),'FaceColor','y','FaceAlpha',sh1,'EdgeAlpha',sh2,'LineWidth',2.5)
legend({(num2str(C(1))),(num2str(C(2))),(num2str(C(3))),(num2str(C(4))),(num2str(C(5)))})
xlabel('CPU time - seconds (S)')
ylabel('%RAM')
title(ax2,'RAM - baremetal - nginx - on Pi1 - 1 PI - 0K')
ylim([0 100])
% xlim([0 2.5])
ax2.FontSize = 14;
grid(ax2,'on')

%plot(S1,A1(:,2),'color',[0.9100    0.4100    0.1700],'LineWidth',7)
% plot(S2,A2(:,2),'--','color',[0.9100    0.4100    0.1700],'LineWidth',2.5)
% plot(S3,A3(:,2),'color',[0.9100    0.4100    0.1700])
% plot(S4,A4(:,2),'color',[0.9100    0.4100    0.1700])
% plot(S5,A5(:,2),'color',[0.9100    0.4100    0.1700])

% figure
% hold on
% plot(S1,A1(:,3))
% plot(S2,A2(:,3))
% plot(S3,A3(:,3))
% plot(S4,A4(:,3))
% plot(S5,A5(:,3))