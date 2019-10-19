function  plotSurf(i,j,ab,test,type,pi)
index=zeros(1,j+1);
count = 0;
percentage = [0;1;2;3;4;5;6;7;8;9;10;11;12;13;14;15;16;17;18;19;20;21;22;23;24;25;26;27;28;29;30;31;32;33;34;35;36;37;38;39;40;41;42;43;44;45;46;47;48;49;50;51;52;53;54;55;56;57;58;59;60;61;62;63;64;65;66;67;68;69;70;71;72;73;74;75;76;77;78;79;80;81;82;83;84;85;86;87;88;89;90;91;92;93;94;95;96;97;98;99;100];
tests=["1 pi","2 pis","3 pis","4 pis","5 pis","6 pis","7 pis","8 pis","9 pis","10 pis"];
for idx = 1:(j+1)
    count=count +(i+1);
    index(:,idx) = count;
end
index2 = (index-5)+1;
pers = ones(101,(i+1)).*percentage;
indexes=zeros(101,(i+1));
for id = 1:5
    indexes(:,id)=ones(101,1)*id;
end
for pidx = 1:j+1
%     figure('units','normalized','outerposition',[0 0 1 1])
%     surf(indexes,pers,ab(:,index2(pidx):index(pidx))*10^-3,'FaceAlpha',0.5)
%     title(test +" - " + tests(pidx))
%     xlabel("iteration of test")
%     ylabel("percentage of requests complete")
    figure('units','normalized','outerposition',[0 0 1 1])
    surf(indexes,pers,ab(:,index2(pidx):index(pidx))*10^-3,'FaceAlpha',0.5)
    title(test +" - " + tests(pidx))
    xlabel("iteration of test")
    ylabel("percentage of requests complete")
    zlabel("time (S)")
    zlabel("time (S)")
    set(gca,'FontSize',20)
    saveas(gcf,pi+"/"+type+"/"+test+"/ABData_"+num2str(pidx)+".png")
    pause(5)
    close
%     colorbar
end
end