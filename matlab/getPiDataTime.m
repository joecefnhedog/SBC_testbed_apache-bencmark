function filedata = getPiDataTime(x,y,test,type,pi)
%     nginxPids = pids(test,type);
%     nginxPids = nginxPids(:,1:5);
    if type == "baremetal"
        nginxPids = pids2(test,type,pi);
        nginxPids = nginxPids(:,1:5);
    elseif type == "docker"
        nginxPids = pids2(test,type,pi);
        nginxPids = nginxPids(:,1:2);
    end
    
    [numberPis,pidLength]=size(nginxPids);
    if numberPis==x
        ("correct match with number of pis")
    else
        ("incorrect size of npis")
    end

    count=0;
    delimiterIn = ' ';
    for j = 1:x
        for i = 1:y
            for k = 1:(j)
                for l = 1:pidLength
                    count=count+1;
                    %fprintf('pi= %d. Iter=%d. pid=%d.\n' , k,i+1,l);
                    %filename = sprintf("/home/joseph/Dropbox/rpi_testbed/pis_0k_baremetal/pi"+num2str(k)+"/" + nginxpi(k,l) +"time%dPI%d.txt",(k-1),i);
                    filename = sprintf("/home/lunet/eljb13/Dropbox/rpi_testbed/"+pi+"/"+type+"/"+test+"/pi"+num2str(k)+"/root/" + num2str(nginxPids(k,l)) +"time%dPI%d.txt",(j-1),(i-1));
                    %filename = sprintf("/home/lunet/eljb13/Dropbox/rpi_testbed/PI3B+/baremetal/0K/pi"+num2str(k)+"/root/" + num2str(nginxPids(k,l)) +"htop-i%dPI%d.txt",(j-1),(i-1));
                    %nginxpi(k,l)
                    %filename
                    opts = detectImportOptions(filename);
                    opts.DataLines=1;
                    %filedata{count} = importdata(filename,opts);
                    filedata{count} = importdata(filename,delimiterIn);
                    %count
                    %filename{i+1} = sprintf("/Users/eljb13/Desktop/pis_0k_baremetal\pi"+num2str(k)+"\" + nginxpi(i,k) +"htop-i%dPI%d.txt",i,k);
                end
            end
            %fprintf('\n')
        end
        
     end
    
end
