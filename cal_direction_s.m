function theta=cal_direction_s(t1,t2,t3)
% label=2

c = 343;  % velocity of sound
A1 = c*t1/0.1;
display(A1);
theta_1=acos(A1/sqrt(2))-pi/4;
A2 = c*t2/0.1;
theta_2=-acos(A2/sqrt(2))+pi/4;
A3 = c*t3/0.2;
theta_3=acos(A3);

theta=(theta_1+theta_2+theta_3)/3;
%theta=theta_3;
end