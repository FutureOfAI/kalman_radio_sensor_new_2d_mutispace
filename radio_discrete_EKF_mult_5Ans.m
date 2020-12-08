function[H,R,Rm_h]=radio_discrete_EKF_mult_5Ans(coordinate,Rm_Index,xpm_Nh,ypm_Nh,sig_x_r,sig_y_r,k,format_1,ans)
if (format_1 == 1) % straight line
    
    coor_diff(:,1) = coordinate(Rm_Index(k,1:ans),2)-xpm_Nh(k);
    coor_diff(:,2) = coordinate(Rm_Index(k,1:ans),3)-ypm_Nh(k);
    coor_diff(:,3) = coordinate(Rm_Index(k,1:ans),4);
    Rm_h(k,1:ans) = sqrt( coor_diff(:,1).*coor_diff(:,1) + coor_diff(:,2).*coor_diff(:,2) + coor_diff(:,3).*coor_diff(:,3) );

elseif (format_1 == 2)% square
%     R1m_h(k) = sqrt((xr1-xpm_Nh(k))^2+(yr1-ypm_Nh(k))^2+(h_1-1.2^2)); 
%     R2m_h(k) = sqrt((xr2-xpm_Nh(k))^2+(yr2-ypm_Nh(k))^2+(h_2-1.2)^2);
%     R3m_h(k) = sqrt((xr3-xpm_Nh(k))^2+(yr3-ypm_Nh(k))^2+(h_3-1.2)^2);
%     R4m_h(k) = sqrt((xr4-xpm_Nh(k))^2+(yr4-ypm_Nh(k))^2+(h_4-1.2)^2);
end

r_partial_x = -( coordinate(Rm_Index(k,1:ans),2)-xpm_Nh(k) )./Rm_h(k,1:ans)';
r_partial_y = -( coordinate(Rm_Index(k,1:ans),3)-ypm_Nh(k) )./Rm_h(k,1:ans)';

H = [r_partial_x zeros(ans,1) zeros(ans,1) r_partial_y zeros(ans,1) zeros(ans,1) zeros(ans,1) zeros(ans,1)];

% if k < 1500
% R = 1*[sig_x_r^2 0 0 0
%     0 sig_y_r^2 0 0
%     0 0 sig_x_r^2 0
%     0 0 0 sig_y_r^2];
% else
R = 1*[sig_x_r^2 0 0 0 0 0
        0 sig_y_r^2 0 0 0 0
        0 0 sig_x_r^2 0 0 0
        0 0 0 sig_y_r^2 0 0
        0 0 0 0 sig_x_r^2 0
        0 0 0 0 0 sig_y_r^2];  
% end

end