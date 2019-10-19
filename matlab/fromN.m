function sum = fromN(n,i,type)

if type == "baremetal"
    pidLength=5;
elseif type == "docker"
    pidLength=2;
end


num = n*pidLength;%n pids
sum = 0;
for idx = 1:i
%     sum
    sum = sum+(idx*(num));
end
% numberOfFiles = [0,50,150,300,500,750,1050,1400,1800,2250,2750];

end