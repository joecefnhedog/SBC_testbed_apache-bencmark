rgb = colormap;
pi = ["PI3B","PI3BPLUS","ODROIDC2"];
type=("baremetal");
test=(["0K","1K","10K","100K"]);
for pidx = 1:length(pi)
    cpuMat = zeros(4,10);
    timMat = zeros(4,10);
    for idx = 1:length(test)
        if pi(pidx) == "PI3B"
            [data0k,legendData] = getPiData4(10,5,test(idx),type,pi(pidx));
            time0k = getPiDataTime(10,5,test(idx),type,pi(pidx));
        elseif pi(pidx) == "PI3BPLUS"
            [data0k,legendData] = getPiData4(10,5,test(idx),type,pi(pidx));
            time0k = getPiDataTime(10,5,test(idx),type,pi(pidx));
        elseif pi(pidx) == "ODROIDC2"
            [data0k,legendData] = getOdroidData(10,5,test(idx),type,pi(pidx));
            time0k = getOdroidDataTime(10,5,test(idx),type,pi(pidx));    
        end
        for jidx = 1:10
            dataTest{jidx} = getTest(jidx+1,data0k,type);
        end
        for jidx = 1:10
            timeTest{jidx} = getTest(jidx+1,time0k,type);
        end
        [allTim,allCpuPointsFinal,~,totMeanCpu] = timeAverageLUQuart(dataTest,timeTest,test(idx),type,pi(pidx));
        [meanTime,lowerQuart,upperQuart,minTime,maxTime] = givingStatsForTime(allTim);
        meanTimeT(idx,:) = meanTime;
        lowerQuartT(idx,:) = lowerQuart; 
        upperQuartT(idx,:) = upperQuart;
        minTimeT(idx,:) = minTime;
        maxTimeT(idx,:) = maxTime;
    end
    mTT(:,:,pidx)=meanTimeT;
    lQT(:,:,pidx)=lowerQuartT;
    uQT(:,:,pidx)=upperQuartT;
    miTT(:,:,pidx)=minTimeT;
    maTT(:,:,pidx)=maxTimeT;
end

figure
hold on
for idf = 1:10
    plot(mTT(:,idf,1),'r-*');plot(mTT(:,idf,2),'b-*');plot(mTT(:,idf,3),'g-*');
end


for t = 4:4
   
    figure
    hold on
    
    for idf = t:t
        plot(mTT(idf,:,1),'r-*');plot(mTT(idf,:,2),'b-*');plot(mTT(idf,:,3),'g-*');
    end
    for idf = t:t
        plot(lQT(idf,:,1),'r*');plot(lQT(idf,:,2),'b*');plot(lQT(idf,:,3),'g*');
    end
    for idf = t:t
        plot(uQT(idf,:,1),'r*');plot(uQT(idf,:,2),'b*');plot(uQT(idf,:,3),'g*');
    end
    for idf = t:t
        plot(lQT(idf,:,1),'r*');plot(miTT(idf,:,2),'b*');plot(miTT(idf,:,3),'g*');
    end
    for idf = t:t
        plot(miTT(idf,:,1),'r*');plot(miTT(idf,:,2),'b*');plot(miTT(idf,:,3),'g*');
    end
    hold off
    legend('pi3b','pi3b+','odroidc2')
    xlabel('Number of SBCs.')
    ylabel('Time Taken.')
    title(num2str(test(t)))
end










