close all; %close all figures
clear all;
clc;       %clear the command line
fclose('all'); %close all open files
delete(instrfindall); %Reset Com Port

obj = serial('com12');
obj.BaudRate = 115200;
obj.Parity = 'none';
obj.StopBits = 1;
count = 500;
fopen(obj);
disp(obj);
data = zeros(32,count);
for i=1:count
    data(:,i) = fread(obj,32);
end

fclose(obj);
delete(obj);

save aj_20.mat data;