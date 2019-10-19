function [filedata,legend] = getPiData4(x,y,test,type,pi)

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
    
    for j = 1:x
        for i = 1:y
            for k = 1:(j)
                for l = 1:pidLength
                    count=count+1;
%                     fprintf('pid=%d',l)
                    %fprintf('pi= %d. Iter=%d. pid=%d.\n' , (k-1),(i-1),l);
%                     filename = sprintf("/home/joseph/Dropbox/rpi_testbed/pis_0k_baremetal/pi"+num2str(k)+"/" + nginxpi(k,l) +"htop-i%dPI%d.txt",(k-1),i);
                    
                    
                    
                    
                    filename = sprintf("/home/lunet/eljb13/Dropbox/rpi_testbed/"+pi+"/"+type+"/"+test+"/pi"+num2str(k)+"/root/" + num2str(nginxPids(k,l)) +"htop-i%dPI%d.txt",(j-1),(i-1));
                    %filename = sprintf("/0K/pi"+num2str(k)+"/root/" + num2str(nginxPids(k,l)) +"htop-i%dPI%d.txt",(j-1),(i-1))
                    
                    
                    
                    %filename = sprintf("/home/lunet/eljb13/Dropbox/rpi_testbed/PI3B+/baremetal/0K/pi"+num2str(k)+"/root/" + nginxpi(k,l) +"htop-i%dPI%d.txt",(k-1),i);
                    opts = detectImportOptions(filename);
                    opts.DataLines=1;
                    filedata{count} = readtable(filename,opts);
                    whos readtable(filename,opts)
                    legend{count} = sprintf(test+"/pi"+num2str(k)+"/root/" + num2str(nginxPids(k,l)) +"htop-i%dPI%d.txt",(j-1),(i-1));
                end
            end
            %fprintf('\n')
        end
        
     end
    
end