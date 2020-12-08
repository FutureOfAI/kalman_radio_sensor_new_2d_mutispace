close all; %close all figures
clear all;
clc;       %clear the command line
fclose('all'); %close all open files
delete(instrfindall); %Reset Com Port

obj = serial('com23');
obj.BaudRate = 57600;
obj.Parity = 'none';
obj.StopBits = 1;
count = 1000;
fopen(obj);
disp(obj);
data = zeros(46,count);
for i=1:count
    data(:,i) = fread(obj,46);
end

fclose(obj);
delete(obj);

save distance_0825.mat data;