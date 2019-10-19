clear all
close all
clc
filename = ("/home/lunet/eljb13/Dropbox/rpi_testbed/PI3B+/docker/0K/pi1/root/3507htop-i0PI2.txt")
opts = detectImportOptions(filename);
opts.DataLines=1;
a = readtable(filename,opts)

% filename = ("/home/lunet/eljb13/Dropbox/rpi_testbed/PI3B+/docker/0K/pi1/root/3507time0PI2.txt")
% delimiterIn = ' ';
% a = importdata(filename,delimiterIn);
