function p = pids2(test,type,pi)



if pi == "ODROIDC2"
    loc1="data";
elseif pi == "PI3BPLUS"
    loc1="root";
elseif pi == "PI3B"
    loc1="root";
end



if type == "baremetal"
    ps=zeros(10,5);
elseif (type == "docker") && (pi == "ODROIDC2")
    ps=zeros(10,5);
elseif type == "docker"
    ps=zeros(10,2);
end

for i = 1:10
    filename = sprintf("/home/lunet/eljb13/Dropbox/rpi_testbed/"+pi+"/"+type+"/"+test+"/pi"+num2str(i)+"/"+loc1+"/pid.txt",i);
    fid = load(filename);
    ps(i,:) = sort(fid(1,:));
end

p = ps;