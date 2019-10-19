function ab=getABData2(i,j,test,pi) 

ab=zeros(101,(i+1)*(j+1));
count=0;
for k = 0:i
    for l = 0:j
        count=count+1;        
        filename = sprintf("/home/lunet/eljb13/Dropbox/rpi_testbed/"+pi+"/baremetal/"+test+"/"+"ab%d-%d.csv",l,k);
        filename
        if isfile(filename)
            abz = table2array(readtable(filename, 'HeaderLines',1));
%             ab1 = abz(:,2);
            ab(:,count) = abz(:,2);
        else
            "that test" +num2str(k)+"-" + num2str(l) + ".csv must have failed"
        end
            %ab{count} = 0;
        %T = table2array(readtable(filename, 'HeaderLines',1));
        %ab{count} = T(:,2);
    end
end

end