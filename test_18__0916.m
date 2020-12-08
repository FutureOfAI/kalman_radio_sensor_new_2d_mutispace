% coordinate = [1,x1,y1,z1;
%               2,x2,y2,z2;
%               3,x3,y3,z3;];
%               
%  Tag_coordinate = [1,6,4,2;
%               2,4,4,2;
%               3,6,6,2;];     
% 
% % =====================================================
% %%  Anchor1 to Tag distance
% d1 = sqrt((x1-6)^2+(y1-4)^2+(z1-2)^2) ;
% d2 = sqrt((x1_4)^2+(y1-4)^2+(z1-2)^2) ;
% d3 = sqrt((x1-6)^2+(y1-6)^2+(z1-2)^2) ;
clear all
close all

num_Anc=10;
max_x=10;
max_y=10;

Anc=rand(2,num_Anc);
Anc(1,:)=Anc(1,:)*max_x;
Anc(2,:)=Anc(2,:)*max_y;

A_real=[0,5.64]

C=[0  0.17  7.78 7.65 ;
   0.9 11.8 11.7 0.13    ];

r(1,:)=sqrt((C(1,1)-Anc(1,:)).^2 + (C(2,1)-Anc(2,:)).^2);
r(2,:)=sqrt((C(1,2)-Anc(1,:)).^2 + (C(2,2)-Anc(2,:)).^2);
r(3,:)=sqrt((C(1,3)-Anc(1,:)).^2 + (C(2,3)-Anc(2,:)).^2);


r1=  sqrt((C(1,1)-A_real(1)).^2 + (C(2,1)-A_real(2)).^2);
r2=  sqrt((C(1,2)-A_real(1)).^2 + (C(2,2)-A_real(2)).^2);
r3=  sqrt((C(1,3)-A_real(1)).^2 + (C(2,3)-A_real(2)).^2);



%error area is +-0.1m
e_A=0.01;
e=randn(3,num_Anc)*e_A;

r_e=r+e;

e_real=0.2;
r1_e=r1+e_real;
r2_e=r2+e_real
r3_e=r3+e_real

b_real=[r2^2-r1^2+C(1,1)^2-C(1,2)^2+C(2,1)^2-C(2,2)^2;r3^2-r1^2+C(1,1)^2-C(1,3)^2+C(2,1)^2-C(2,3)^2];
b_real_e=[r2_e^2-r1_e^2+C(1,1)^2-C(1,2)^2+C(2,1)^2-C(2,2)^2;r3_e^2-r1_e^2+C(1,1)^2-C(1,3)^2+C(2,1)^2-C(2,3)^2];

A=[2*(C(1,1)-C(1,2)) 2*(C(2,1)-C(2,2));2*(C(1,1)-C(1,3)) 2*(C(2,1)-C(2,3))];
b=[r(2,:).^2-r(1,:).^2+C(1,1)^2-C(1,2)^2+C(2,1)^2-C(2,2)^2;r(3,:).^2-r(1,:).^2+C(1,1)^2-C(1,3)^2+C(2,1)^2-C(2,3)^2];
b_e=[r_e(2,:).^2-r_e(1,:).^2+C(1,1)^2-C(1,2)^2+C(2,1)^2-C(2,2)^2;r_e(3,:).^2-r_e(1,:).^2+C(1,1)^2-C(1,3)^2+C(2,1)^2-C(2,3)^2];
Solution_Anc=inv(A)*b;
Solution_Anc_e=inv(A)*b_e;

Solution_Anc_real=inv(A)*b_real;
Solution_Anc_real_e=inv(A)*b_real_e;

dis_e=Solution_Anc_e-Anc;
er(:)=sqrt(dis_e(1,:).^2+dis_e(2,:).^2);

mean(er)

% E=S-A

%plot(4,4,'rsquare',4,6,'rsquare',6,6,'rsquare')

%plot(0,0,'r*',0,8,'r*',8,8,'r*',8,0,'r*')
%plot(A(1,1),A(2,1),'rsquare',S(1,1),S(2,1),'r*',A(1,2),A(2,2),'gsquare',S(1,2),S(2,2),'g*',A(1,3),A(2,3),'bsquare',S(1,3),S(2,3),'b*',A(1,4),A(2,4),'csquare',S(1,4),S(2,4),'c*',A(1,5),A(2,5),'msquare',S(1,5),S(2,5),'m*',A(1,6),A(2,6),'rsquare',S(1,6),S(2,6),'r*',A(1,7),A(2,7),'ysquare',S(1,7),S(2,7),'y*',A(1,8),A(2,8),'ksquare',S(1,8),S(2,8),'k*',A(1,9),A(2,9),'wsquare',S(1,9),S(2,9),'w*');
% plot(A(1,10),A(2,10),'rsquare',S(1,10),S(2,10),'r*');

%¹Ï¤ù
figure (1)
plot(Anc(1,:),Anc(2,:),'rsquare', Solution_Anc_e(1,:),Solution_Anc_e(2,:),'bsquare');
% 
% figure (2)
% bar(er);













% hold on
% title('Test')
% xlabel('Y position in m')
% ylabel('X position in m')
% axis([-5 15 -5 20])
% grid