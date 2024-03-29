
n1 = 400;
n2 = 100;
n2 = k-1;
%t00 = time;
figure (3)
subplot(311)
plot(x_p_N,y_p_N,xr1,yr1,'r*',xr2,yr2,'r*')
xlabel('X position in m')
ylabel('Y position in m')
grid
subplot(312)
plot(t00,x_v_N,'r',t00,y_v_N)
xlabel('Time in sec')
ylabel('Velocity in m/s')
grid
subplot(313)
plot(t0,x_a_B/g,'r',t0,y_a_B/g,'g')
ylabel('X-Y body accel in g')
xlabel('Time in sec')
axis([t0(1) t0(k-1) -1 1])
grid
%
figure (8)
subplot(211)
plot(t00,x_a_N/g,'r')
%xlabel('Time in sec')
ylabel('X accel in g')
subplot(212)
plot(t00,y_a_N/g,'r')
%xlabel('Time in sec')
ylabel('Y accel in g')
%
%
figure(7);
subplot(3,1,1), plot(t0,bx/g,'r',t0,bx_h/g,'g');         
xlabel('Time in seconds');ylabel('Accel bias along-axis in g');
subplot(3,1,2), plot(t0,by/g,'r',t0,by_h/g,'g');         
xlabel('Time in seconds');ylabel('Accel bias perp-axis in g');
subplot(3,1,3), plot(t0,bz*r2d,'r',t0,bz_h*r2d,'g');
xlabel('Time in seconds');ylabel('Gyro bias in deg');
%
figure (1)
subplot(3,1,1), plot(t0,bx/g,'r');         
xlabel('Time in seconds');ylabel('Accel bias along-axis in g');
subplot(3,1,2), plot(t0,by/g,'r');         
xlabel('Time in seconds');ylabel('Accel bias perp-axis in g');
subplot(3,1,3), plot(t0,bz*r2d,'r');
xlabel('Time in seconds');ylabel('Gyro bias in deg/sec');
%
figure (2)
subplot(2,1,1), plot(t0(n1:n2),(bx(n1:n2)-bx_h(n1:n2))/g,'r');         
xlabel('Time in seconds');ylabel('Accel bias err in x-axis in g');
grid
subplot(2,1,2), plot(t0(n1:n2),(by(n1:n2)-by_h(n1:n2))/g,'r');         
xlabel('Time in seconds');ylabel('Accel bias y-axis in g');
grid
%
