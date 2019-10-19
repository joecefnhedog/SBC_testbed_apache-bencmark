function [voltage1,voltage2,time1]=voltage_data(test,type)
times = ["10550","10700","10800","26300"];
if test == ("0K")
    timeToUSe = times(1);
elseif test == ("1K")
    timeToUSe = times(2);
elseif test == ("10K")
    timeToUSe = times(3);
elseif test == ("100K")
    timeToUSe = times(4);
end
filename = sprintf("/home/lunet/eljb13/Dropbox/rpi_testbed/PI3B+/"+type+"/"+"ab/"+"voltage1-"+timeToUSe+".csv");
filename2 = sprintf("/home/lunet/eljb13/Dropbox/rpi_testbed/PI3B+/"+type+"/"+"ab/"+"voltage2-"+timeToUSe+".csv");
filename3 = sprintf("/home/lunet/eljb13/Dropbox/rpi_testbed/PI3B+/"+type+"/"+"ab/"+"time-"+timeToUSe+".csv");

voltage1 = importdata(filename);
voltage2 = importdata(filename2);
time1 = importdata(filename3);
end