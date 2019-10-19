clear all
close all
clc
 pi=["PI3B","PI3B+"];
%pi=["PI3B"];
type=("baremetal");
test=(["0K","1K","10K","100K"]);
%test=(["0K"]);
figure('units','normalized','outerposition',[0 0 1 1]);    
for pdx = 1:length(pi)
    for tdx = 1:length(test)
        [nginxTimes,piStartTimes]=reference_test_times(test(tdx),type,pi(pdx));
        %need to pull the test times, how long do the tests run for. 
        %first guess is jut to pull the maximum time it has taken for each test.
        [data0k,legendData] = getPiData4(10,5,test(tdx),type,pi(pdx));
        time0k = getPiDataTime(10,5,test(tdx),type,pi(pdx));

        for jidx = 1:10
            dataTest{jidx} = getTest(jidx+1,data0k,type);
        end

        for jidx = 1:10
            timeTest{jidx} = getTest(jidx+1,time0k,type);
        end
        [allCpuPointsFinal,maxTime,totMeanCpu] = plotCpuNginxAverage(dataTest,timeTest,test(tdx),type);

        nPi=10;
        n=5;
        y = [50 -0.5];
        [v1,v2,t1]=voltage_data(test(tdx),type);

        % averV2 = movmean(v2,40);
        % figure('units','normalized','outerposition',[0 0 1 1]);
        % hold on;plot(t1,(v2)/0.0412);plot(t1,v1.*(v2/0.0412),'--b')
        %  
        % for idx = 1:nPi
        %     x2 = [piStartTimes(idx) piStartTimes(idx)];
        %     line(x2,y,'Color','red','LineStyle','--')
        %     for jdx = 1:n
        %         x = [nginxTimes(idx,jdx) nginxTimes(idx,jdx)];
        %         xend = [nginxTimes(idx,jdx)+cell2mat(maxTime(idx)) nginxTimes(idx,jdx)+cell2mat(maxTime(idx))];
        %         line(x,y)
        %         line(xend,y,'Color','green','LineStyle','--')
        %     end
        % end


        averPower= zeros(10,5);
        averPower2= zeros(10,1);
        for idx = 1:nPi
            for jdx = 1:5
                n=nginxTimes(1,1);
                [val,idxStart]=min(abs(t1-n));
                nE=nginxTimes(idx,jdx)+cell2mat(maxTime(idx));
                [valE,idxEnd]=min(abs(t1-nE));
                v2(idxStart:1:idxEnd);
                averPower(idx,jdx)=mean(v1(idxStart:1:idxEnd).*(v2(idxStart:1:idxEnd)/0.0412));
            end
        end
        for i = 1:10
            averPower2(i,:) = mean(averPower(i,:));
        end
        aP(tdx,:)=averPower2;
        timMat(tdx,:)= maxTime;
    end
    
    for i = 1:10
        for j=1:4
            amahl(j,i) = cell2mat(timMat(j,1))/cell2mat(timMat(j,i));
        end
    end


%     bar3(amahl)
%     xlabel('number of pis running the test.')
%     yticks([1 2 3 4])
%     yticklabels({'0k','1k','10k','100k'})
%     ylabel('datafile')
%     zlabel('average power usage')
%     %view([60 30])
%     %zlim([5 25])
%     title(pi(pdx)+' '+type)

    subplot(1,2,pdx)
    bar3(amahl)
    xlabel('number of pis running the test.')
    yticks([1 2 3 4])
    yticklabels({'0k','1k','10k','100k'})
    ylabel('datafile')
    zlabel('speed-up')
    %view([60 30])
    %zlim([5 25])
    title(pi(pdx)+' '+type)
    % shading interp;

    % colormap(colorcube)
    % colorbar

%     saveas(gcf,pi(pidx)+"/"+"barcpu.png")
%     close

%     figure('units','normalized','outerposition',[0 0 1 1]);
%     subplot(2,2,pdx+2)
%     bar3(aP)
%     xlabel('data file')
%     xticks([1 2 3 4])
%     xticklabels({'0k','1k','10k','100k'})
%     ylabel('number of pis running the test.')
%     zlabel('time taken for AB test')
%     title(pi(pdx)+' '+type)
    % view([60 30])
    %zlim([0 1000])
%     saveas(gcf,pi(pidx)+"/"+"3dTim.png")
%     close
end



