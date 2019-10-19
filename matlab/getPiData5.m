function filedata = getPiData5(i2,j2,p2)
for t = 1:10
    for i=1:t
        for j = 1:2
            for p = 1:2
                fprintf('pi= %d. Iter=%d. pid=%d.\n' , (i),(j),(p));
            end
        end    
    end
    fprintf('\n')
end  
end