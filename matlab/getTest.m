function testData = getTest(i,list,type)
nPi=10;
n=5;

% numberOfFiles = [0,50,150,300,500,750,1050,1400,1800,2250,2750];
numberOfFiles = [fromN(n,0,type),fromN(n,1,type),fromN(n,2,type),fromN(n,3,type),fromN(n,4,type),fromN(n,5,type),fromN(n,6,type),fromN(n,7,type),fromN(n,8,type),fromN(n,9,type),fromN(n,10,type)];

count=0;
for i1= numberOfFiles(i-1)+1:numberOfFiles(i)
    count=count+1;
    testData{count} = list{i1}; 
end



end
    