n1 = 1;
n2 = 500;
n2 = k-1;
%%  select 1 = original data ; select 2 = low pass filter data
select = 1;

if select == 1

figure (1)
plot(t0(n1:n2),gro(3,n1:n2)*r2d)%
xlabel('Time in seconds');ylabel('Angular rate in deg/sec');

figure (2)
plot(t0(n1:n2),((gro(3,n1:n2)'-bz_h(n1:n2))*r2d))%gro(3,n1:n2)'-bz_h(n1:n2))   linVelLP(n1:n2,3)
xlabel('Time in seconds');ylabel('Angular rate error in deg/sec');

figure (3)
plot(t0(n1:n2),(acc(1,n1:n2)'-bx_h(n1:n2)))
xlabel('Time in seconds');ylabel('x accelerate error in g');

figure (4)
plot(t0(n1:n2),(acc(2,n1:n2)'-by_h(n1:n2)))
xlabel('Time in seconds');ylabel('y accelerate error in g');

%square turn one circle is 1900 seconed
figure (5)
plot(t0(n1:n2),(psi_h(n1:n2)')*r2d)
xlabel('Time in seconds');ylabel('psi_h Angle in deg');

figure (6)
subplot(311)
plot(t0(n1:n2),gro(3,n1:n2)*r2d)%
xlabel('Time in seconds');ylabel('Angular rate in deg/sec');
subplot(312)
plot(t0(n1:n2),((gro(3,n1:n2)'-bz_h(n1:n2))*r2d))%gro(3,n1:n2)'-bz_h(n1:n2))   linVelLP(n1:n2,3)
xlabel('Time in seconds');ylabel('Angular rate error in deg/sec');
subplot(313)
plot(t0(n1:n2),(psi_h(n1:n2)')*r2d)
xlabel('Time in seconds');ylabel('psi_h Angle in deg');

end
%% low pass filter
if select == 2

figure (1)
plot(t0(n1:n2),low_gro(3,n1:n2)*r2d)%
xlabel('Time in seconds');ylabel('Angular rate in deg/sec');

figure (2)
plot(t0(n1:n2),((low_gro(3,n1:n2)'-bz_h(n1:n2))*r2d))%gro(3,n1:n2)'-bz_h(n1:n2))   linVelLP(n1:n2,3)
xlabel('Time in seconds');ylabel('Angular rate error in deg/sec');

figure (3)
plot(t0(n1:n2),(acc(1,n1:n2)'-bx_h(n1:n2)))
xlabel('Time in seconds');ylabel('x accelerate error in g');

figure (4)
plot(t0(n1:n2),(acc(2,n1:n2)'-by_h(n1:n2)))
xlabel('Time in seconds');ylabel('y accelerate error in g');

figure (5)
plot(t0(n1:n2),(psi_h(n1:n2)')*r2d)
xlabel('Time in seconds');ylabel('psi_h Angle in deg');

figure (6)
subplot(311)
plot(t0(n1:n2),low_gro(3,n1:n2)*r2d)%
xlabel('Time in seconds');ylabel('Angular rate in deg/sec');
subplot(312)
plot(t0(n1:n2),((low_gro(3,n1:n2)'-bz_h(n1:n2))*r2d))%gro(3,n1:n2)'-bz_h(n1:n2))   linVelLP(n1:n2,3)
xlabel('Time in seconds');ylabel('Angular rate error in deg/sec');
subplot(313)
plot(t0(n1:n2),(psi_h(n1:n2)')*r2d)
xlabel('Time in seconds');ylabel('psi_h Angle in deg');

end