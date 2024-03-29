% Program name: radio_sensor_mutil_space_0302.m
% A new program that deal with non-constant psi angle where
% a 8-state Kalman filter with 10 radio sensors without optical flow
% sensors
close all;
clear all;
clc;
format short e
r2d = (180/pi);
d2r = (pi/180);
g =9.8;
%

%======================================================
% Design parameters to be tuned
%======================================================
% Select motion profiles
% trajectory is generated in navigation frame (N-frame)
%================================
% Set motion profile flags
% profile_flag = 1:         straight motion
% profile_flag = 2;         circular motion
% profile_flag = 3;         race track motion
profile_flag = 1;
%
if (profile_flag ==1),
%% Straight motion
% =====================================================
% Straight motion with psi = constant angle, or wn = 0
% =====================================================
% positions of two ratio sensors's positions
% =====================================================
%             idx x y z 
coordinate = [1,0,25,4;
              2,0,-25,4;
              3,25,25,4;
              4,25,-25,4;
              5,-25,25,4;
              6,-25,-25,4];
%
dt = 0.01;
T = 200;
t0 = 0:dt:T;
t0_1 = t0';
n = length(t0);
m = size(t0_1);
t00 = t0;
%
fn = 0*0.05;
psi_0 = 1*45*d2r; % Slope of trajectory
wn = 2*pi*fn;
wz(1) = wn;
psi(1) = psi_0 + wz(1)*t0(1);
for i = 2:n,
wz(i) = wn;
psi(i) = psi(i-1) + (wz(i) + wz(i-1))*dt/2;
end
% ====================================================
ft =1* 0.05;
wt = 2*pi*ft;
radius_x = 50;
radius_y = 25;
[x_p_N,x_v_N,x_a_N,y_p_N,y_v_N,y_a_N] = trajectory_mult(radius_x,radius_y,psi_0,wt,t0);
else
    if (profile_flag ==2),
%% Circular motion        
% ====================================================
% Circular motion with psi = 2*pi*fn*t
% =====================================================
% positions of two ratio sensors's positions
% ================================
%   idx x y z 
coordinate = [1,-50,50,4;
              2,-30,50,4;
              3,-10,50,4;
              4,10,50,4;
              5,30,50,4;
              6,50,50,4;
              7,-50,0,4;
              8,-30,0,4;
              9,-10,0,4;
              10,10,0,4;
              11,30,0,4;
              12,50,0,4;
              13,-50,-50,4;
              14,-30,-50,4;
              15,-10,-50,4;
              16,10,-50,4;
              17,30,-50,4;
              18,50,-50,4;];
%
% dt = 0.01;
T = 200;
t0 = 0:dt:T;
t0_1 = t0';
n = length(t0);
m = size(t0_1);
t00 = t0;
%
fn = 1*0.05;
psi_0 = 0*45*d2r;
wn = 2*pi*fn;
wz(1) = wn;
psi(1) = psi_0 + wz(1)*t0(1);
for i = 2:n,
wz(i) = wn;
psi(i) = psi(i-1) + (wz(i) + wz(i-1))*dt/2;
if (psi(i) >= 2*pi),
    psi(i) = psi(i) - 2*pi;
else
    psi(i) = psi(i);
end
end
radius = 50;
[x_p_N,x_v_N,x_a_N,y_p_N,y_v_N,y_a_N] = trajectory (radius,psi,wn);%round cycle
% ====================================================
    end
end
% ====================================================
% Need to convert into body frame (B-frame) for accelerometer sensings and optical
% flow sensing since they are mounted on the body frame
% ====================================================
x_v_B = zeros(1,n);
y_v_B = zeros(1,n);
%
x_a_B = zeros(1,n);
y_a_B = zeros(1,n);
% ================================
for i = 1:n,
    x_a_B(i) = [cos(psi(i)) sin(psi(i))]*[x_a_N(i)+wz(i)*y_v_N(i);y_a_N(i)-wz(i)*x_v_N(i)];
    y_a_B(i) = [-sin(psi(i)) cos(psi(i))]*[x_a_N(i)+wz(i)*y_v_N(i);y_a_N(i)-wz(i)*x_v_N(i)];
end
    x_v_B(1) = [cos(psi(1)) sin(psi(1))]*[x_v_N(1);y_v_N(1)];
    y_v_B(1) = [-sin(psi(1)) cos(psi(1))]*[x_v_N(1);y_v_N(1)];
for i = 2:n,
    x_v_B(i) = x_v_B(i-1) + (x_a_B(i) + x_a_B(i-1))*dt/2;
    y_v_B(i) = y_v_B(i-1) + (y_a_B(i) + y_a_B(i-1))*dt/2;
end

% plot_trajectory;

% ========================================================
% Define inertial sensor parameters "accelerate mpu9150"
% ========================================================
% gyroscope
bz0=1*0.5*d2r;                            % initial gyro bias in rad/sec
%=============================================================================================================
% gyroscope(bias & noise)
%=====================================
sig_arw_0 = 1*0.02;                       % gyro angle random walk = 0.02 deg/sqrt(sec)
sig_rrw_0 = 0.02/3600;                    % gyro rate random walk = 0.02 deg/3600/sec-sqrt(sec);
[bz]=Biasbg1(dt,n,m,bz0,d2r,sig_rrw_0);
[wzm]=Wzm1(wz,bz,m,n,d2r,sig_arw_0);

%=============================================================================================================
% accelerometer (biases and noises)
%=====================================
bx0=1*0.1*g;                             % initial accel bias in g in along-direction
by0=-0.1*g;                              % initial accel bias in g in perpenticular-direction
err_factor = 1.0;
%
sig_xr_0 = err_factor*0.1*g/3600;         % accel bias stability in g/sec-sqrt(sec) in along-direction
sig_yr_0 = err_factor*0.1*g/3600;         % accel bias stability in g/sec-sqrt(sec) in penpenticular-direction

% accelerate (noise)
sig_bx_0 = err_factor*0.01*g;              % accel noise in g in along-direction
sig_by_0 = err_factor*0.01*g;              % accel noise in g in penpenticular-direction

% accelerate (calculator bias)
[bx]=Biasba1(dt,n,m,bx0,sig_xr_0);
[by]=Biasbp1(dt,n,m,by0,sig_yr_0);
[axm,aym]=transform_m(x_a_B,bx,y_a_B,by,m,n,sig_bx_0,sig_by_0);

% calculator "Q" use bias & noise
sig_bx=sig_bx_0;%(noise)
sig_by=sig_by_0;%(noise)
sig_xr=sig_xr_0;%(bias)
sig_yr=sig_yr_0;%(bias)

% Define ""radio sensor"" parameters (noise)
radiosensor_err_factor = 1.0;
sig_x_r=radiosensor_err_factor*0.1;              % radio sensor measurement noise in meters x-direction
sig_y_r=radiosensor_err_factor*0.1;              % radio sensor measurement noise in meters y-direction
%=========================================================
[Rm_data,Rm_Index,nvx_r,nvy_r] = radio_sensor_m_mult(coordinate,x_p_N,y_p_N,sig_x_r,sig_y_r,n,m);%8-state
%=========================================================
delta_t = dt;                                   % delta time for simulating the true dynamics = 0.01 sec
delta_s = 1*delta_t;                            % sampling at every 0.1 second for the Kalman filter
%================================================================
[sensor_step,propagation_step]=propagate_step(T,delta_t,delta_s);
%================================================================
% Define the initial conditions for the inertial sensors and the navigation
% states
%===============================================================
% Introduce initial position and velocity estimate error in N-frame
xverr = 0.1;        % in meters/sec
yverr = -0.1;       % in meters/sec
xperr = 0.5;        % in m
yperr = -0.5;       % in m
xaerr = 0;          % in m/sec^2
yaerr = 0;          % in m/sec^2
psierr = 0.5;       % in deg
[xpm_Nh,ypm_Nh,xvm_Nh,yvm_Nh,xam_Nh,yam_Nh,axm_h,aym_h,by_h,bx_h,wzm_h,psi_h,bz_h]=initial_estimate_value8_radio(m,x_a_N,y_a_N,x_v_N,y_v_N,x_p_N,y_p_N,wzm,axm,aym,psi,d2r,xverr,yverr,xperr,yperr,xaerr,yaerr,psierr,y_p_N(1),x_p_N(1),bz0);
%================================================================
% Define the initial conditions for the 8-state Kalman Filter
% ==============================================================
% It is noted that we need to increase (100 times) the initial covariance matrix values
% in P00_z(8,8) to make the gyro bias error more observable
% ==============================================================
[xz_h,P00_z]=define_initial_condition_8(bx0,by0,bz0,xperr,yperr,xverr,yverr,psierr,d2r);
% ==============================================================
% for 8-state filter
F_z=zeros(8);
%F_z = [0 1 0 0 0 0 0 0
%       0 0 f23 0 f25 f26 f27 f28
%       0 0 0 0 0 0 0 0
%       0 0 0 0 1 0 0 0
%       0 f52 f53 0 0 f56 f57 f58
%       0 0 0 0 0 0 0 0
%       0 0 0 0 0 0 0 -1
%       0 0 0 0 0 0 0 0];
F_z(1,2) = 1;
F_z(4,5) = 1;
F_z(7,8) = -1;
Q_z=zeros(8);

% ============================================================
% Start the simulation run
% ============================================================
k=2;
for i=1:sensor_step
	for j=1:propagation_step
        k=1+j+(i-1)*propagation_step;
        
        bx_h(k)=bx_h(k-1);
        by_h(k)=by_h(k-1);
        bz_h(k)=bz_h(k-1);
% =========================================        
% Perform inertial navigation computations
% =========================================
        [xpm_Nh,ypm_Nh,xvm_Nh,yvm_Nh,xam_Nh,yam_Nh,axm_h,aym_h,wzm_h,psi_h]=inertial_navigation_computation8_radio(xvm_Nh,yvm_Nh,xpm_Nh,ypm_Nh,xam_Nh,yam_Nh,axm,aym,bx_h,by_h,psi_h,wzm,bz_h,k,dt,0);
    
% ===========================================================
% Perform Kalman filter propagation for 8-state Kalman filter
% ===========================================================
        [phi_z,Q_z,F_z]=define_Dymamic_equation8_radio(F_z,Q_z,axm_h,aym_h,xvm_Nh,yvm_Nh,wzm_h,psi_h,sig_bx,sig_by,sig_xr,sig_yr,sig_arw_0,sig_rrw_0,dt,k,1);
        [xz_h,P00_z]=Kalman_Filter_estimate1_radio(xz_h,phi_z,P00_z,Q_z,dt);
    end                 % end of filter propagation step
% =======================================================
% Perform Kalman filter updates for 8-state filter
% =======================================================

    [H,R,Rm_h]=radio_discrete_EKF_mult(coordinate,Rm_Index,xpm_Nh,ypm_Nh,sig_x_r,sig_y_r,k,1);
    
%   
    [P00_z,K_z,z_update]=Kalman_Filter_update_mult_radio(P00_z,Rm_data,H,R,Rm_h,k);
    
    [xpm_Nh,ypm_Nh,xvm_Nh,yvm_Nh,psi_h,bz_h,bx_h,by_h]=upon_radiosensor_measurement_8_2(xpm_Nh,ypm_Nh,xvm_Nh,yvm_Nh,k,psi_h,bz_h,bx_h,by_h,z_update);
    
% reset the errors after the filter updates
    xz_h=zeros(8,1);
end                     % end of one Monte Caro run

%
n1 = 0.5*(k-1);
n2 = k-1;
%
x_err = x_p_N-xpm_Nh';
y_err = y_p_N-ypm_Nh';
% 3-sigma
D = [sort(abs(x_err(n1:n2)')) sort(abs(y_err(n1:n2)'))];
N = length(D);
number = fix(0.9973*N);
D1 = [D(number,1) D(number,2)]
% ============================================================
% Plot the performance
% ============================================================
% plot the filter performance related to the 2-state Kalman filters
%t00 = time;
plot18;
% ============================================================
% plot the filter performance related to the 4-state Kalman filter
plot28;
%
