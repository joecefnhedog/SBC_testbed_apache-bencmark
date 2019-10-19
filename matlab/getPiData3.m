function filedata = getPiData3(x,y)

    nginxPids = pids("0K");
    nginxPids = nginxPids(:,1:5);
    count=0;
    
    for j = 0:x
        for i = 0:y
            for k = 1:(j+1)
                for l = 1:5
                    count=count+1
                    %fprintf('pi= %d. Iter=%d. pid=%d.\n' , k,i+1,l);
                    %filename = sprintf("/home/joseph/Dropbox/rpi_testbed/pis_0k_baremetal/pi"+num2str(k)+"/" + nginxpi(k,l) +"htop-i%dPI%d.txt",(k-1),i);
                    filename = sprintf("/home/lunet/eljb13/Dropbox/rpi_testbed/PI3B+/baremetal/0K/pi"+num2str(k)+"/root/" + num2str(nginxPids(k,l)) +"htop-i%dPI%d.txt",(k-1),i)
                    %filename = sprintf("/home/lunet/eljb13/Dropbox/rpi_testbed/PI3B+/baremetal/0K/pi"+num2str(k)+"/root/" + nginxpi(k,l) +"htop-i%dPI%d.txt",(k-1),i);
                    filedata{count} = readtable(filename);
                end
            end
            fprintf('\n')
        end
        
     end
    
end
