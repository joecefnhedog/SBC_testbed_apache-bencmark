function [nginxTimes,piStartTimes]=reference_test_times(test,type,pi)
if test == ("0K")
    toUSe = 0;
elseif test == ("1K")
    toUSe = 1;
elseif test == ("10K")
    toUSe = 2;
elseif test == ("100K")
    toUSe = 3;
end

filename = sprintf("/home/lunet/eljb13/Dropbox/rpi_testbed/"+pi+"/"+type+"/"+test+"/ab/"+"apacheBench"+toUSe+".txt");
command = "tr -d '\n' < "+filename ;
[status,cmdout] = system(command);
%filename2 = sprintf("/home/lunet/eljb13/Dropbox/rpi_testbed/PI3B+/"+type+"/"+test+"/ab/"+"picoTimeData"+toUSe+".txt");
filename3 = sprintf("/home/lunet/eljb13/Dropbox/rpi_testbed/"+pi+"/"+type+"/"+test+"/ab/"+"piTimeData"+toUSe+".txt")


nginxTimes = strrep(cmdout,']','];');
%totTime = importdata(filename2);
piStartTimes = importdata(filename3);
piStartTimes = str2num(cell2mat(piStartTimes));



nginxTimes = str2num(nginxTimes);
end