function filedata = getPiDataTimeDocker(x,y,test,type,pi)
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
                    filename = sprintf("/home/lunet/eljb13/Dropbox/rpi_testbed/"+pi+"/"+type+"/"+test+"/pi"+num2str(k)+"/root/" + num2str(nginxPids(k,l)) +"time%dPI%d.txt",(j-1),(i-1));
                    if isfile(filename)                                   
                        opts = detectImportOptions(filename);
                        opts.DataLines=1;
                        filedata{count} = importdata(filename,delimiterIn);
                        
                    else
                        filedata{count} = {'00:00:00.000';'00:00:00.000'};
                    end                    

                end
            end
            %fprintf('\n')
        end
        
     end
    
end
