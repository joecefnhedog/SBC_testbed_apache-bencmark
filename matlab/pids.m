function p = pids(test,type)

ps=zeros(10,5);
for i = 1:10
    filename = sprintf("/home/lunet/eljb13/Dropbox/rpi_testbed/PI3B+/"+type+"/"+test+"/pi"+num2str(i)+"/root/pid.txt",i);
    fid = load(filename);
    ps(i,:) = sort(fid(1,:));
end

p = ps;