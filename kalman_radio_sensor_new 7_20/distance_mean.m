for i = 1:1000
mean_1(1,i) = 0.9*1-VarName1(i,1);%0.9m
mean_2(1,i) = 0.9*2-VarName2(i,1);%1.8m
mean_3(1,i) = 0.9*3-VarName3(i,1);%2.7m
mean_4(1,i) = 0.9*4-VarName4(i,1);%3.6m
mean_5(1,i) = 0.9*5-VarName5(i,1);%4.5m
mean_6(1,i) = 0.9*6-VarName6(i,1);%5.4m
mean_7(1,i) = 0.9*7-VarName7(i,1);%6.3m
mean_8(1,i) = 0.9*8-VarName8(i,1);%7.2m
mean_9(1,i) = 0.9*9-VarName9(i,1);%8.1m
mean_10(1,i) = 0.9*10-VarName10(i,1);%9.0m

end
mean_1_value = mean(VarName1(1:1000,1));
mean_1_err = mean(abs(mean_1(1,:)));
std_1 = std(mean_1(1,:));
sigma_1 = abs(mean_1_err) + (3*std_1);

mean_2_value = mean(VarName2(1:1000,1));
mean_2_err = mean(abs(mean_2(1,:)));
std_2 = std(mean_2(1,:));
sigma_2 = abs(mean_2_err) + (3*std_2);

mean_3_value = mean(VarName3(1:1000,1));
mean_3_err = mean(abs(mean_3(1,:)));
std_3 = std(mean_3(1,:));
sigma_3 = abs(mean_3_err) + (3*std_3);

mean_4_value = mean(VarName4(1:1000,1));
mean_4_err = mean(abs(mean_4(1,:)));
std_4 = std(mean_4(1,:));
sigma_4 = abs(mean_4_err) + (3*std_4);

mean_5_value = mean(VarName5(1:1000,1));
mean_5_err = mean(abs(mean_5(1,:)));
std_5 = std(mean_5(1,:));
sigma_5 = abs(mean_5_err) + (3*std_5);

mean_6_value = mean(VarName6(1:1000,1));
mean_6_err = mean(abs(mean_6(1,:)));
std_6 = std(mean_6(1,:));
sigma_6 = abs(mean_6_err) + (3*std_6);

mean_7_value = mean(VarName7(1:1000,1));
mean_7_err = mean(abs(mean_7(1,:)));
std_7 = std(mean_7(1,:));
sigma_7 = abs(mean_7_err) + (3*std_7);

mean_8_value = mean(VarName8(1:1000,1));
mean_8_err = mean(abs(mean_8(1,:)));
std_8 = std(mean_8(1,:));
sigma_8 = abs(mean_8_err) + (3*std_8);

mean_9_value = mean(VarName9(1:1000,1));
mean_9_err = mean(abs(mean_9(1,:)));
std_9 = std(mean_9(1,:));
sigma_9 = abs(mean_9_err) + (3*std_9);

mean_10_value = mean(VarName10(1:1000,1));
mean_10_err = mean(abs(mean_10(1,:)));
std_10 = std(mean_10(1,:));
sigma_10 = abs(mean_10_err) + (3*std_10);


% mean_1_value
% mean_2_value
% mean_3_value
% mean_4_value
% mean_5_value
% mean_6_value
% mean_7_value
% mean_8_value
% mean_9_value
% mean_10_value
% mean_1_err
% mean_2_err
% mean_3_err
% mean_4_err
% mean_5_err
% mean_6_err
% mean_7_err
% mean_8_err
% mean_9_err
% mean_10_err

std_1
std_2
std_3
std_4
std_5
std_6
std_7
std_8
std_9
std_10
% 
% sigma_1
% sigma_2
% sigma_3
% sigma_4
% sigma_5
% sigma_6
% sigma_7
% sigma_8
% sigma_9
% sigma_10
