clear all
close all
clc

filename = '/home/joseph/Dropbox/rpi_testbed/0k_5_data/data1/htop-i0PI0.txt';
% A = load(filename);
T = readtable(filename);
T = sortrows(T,[1 4]);%sort rows by the first colum, then 4th to keep time ordered.
A = table2array(T(:,1:3));
