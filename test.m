clc;clear all; close all;
a=[1 3 9 4 5 3 3 8];
[b,j]=find_2min(a);
t=1/20000;
c1=5*t;
c2=7*t;
c3=12*t;
theta = cal_direction_b(c1,c2,c3);
theta= rad2deg(theta);
theta1 = cal_direction_s(c1,c2,c3);
theta1= rad2deg(theta1);

theta2=theta+theta1;
%d = 1;
%theta = rad2deg(acos(d)); 

%d=[1 3 1 0];
%[t1,t2,t3,label]=judge_area(d,20000);
