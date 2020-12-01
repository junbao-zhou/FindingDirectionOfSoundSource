clc;clear all; close all;

sound_index = 1;
is_plot = false;


for sound_index = 2:14

% 数据录入
path = './train';
y = [];
for i = 1:4
    [y(i,:),fs1]=audioread(['train/',num2str(sound_index),'_mic',num2str(i),'.wav']);
end
t=1:1:size(y,2);

% draw
if is_plot
    figure(1);
    for i = 1:4
        subplot(2,2,i);
        stem(t,y(i,:));
    end
end

% pre
pre_emphasis=0.97;
y_pre = [];
for i = 1:4
    y_pre(i,:)=filter([1,-pre_emphasis],1,y(i,:));
end

%draw post-pre 
if is_plot
    figure(2);
    for i = 1:4
        subplot(2,2,i);
        stem(t,y_pre(i,:));
    end
end

y_pre_norm = y_pre*1.0./max(y_pre,[],2);
%figure(3);
%stem(t,y1_pre);
 
%找起始点：
y_init=[find(y_pre_norm(1,:),1) find(y_pre_norm(2,:),1) find(y_pre_norm(3,:),1) find(y_pre_norm(4,:),1)];

%判定使用区域： judge_area()函数
[t1,t2,t3,label]=judge_area(y_init,fs1);
switch label
    case 1
        theta=cal_direction_b(t1,t2,t3);
    case 2
        theta=cal_direction_s(t1,t2,t3);
    case 3
        theta=cal_direction_b(t1,t2,t3)-pi*3/2;
    case 4
        theta=cal_direction_s(t1,t2,t3)+pi/2;
    case 5
        theta=cal_direction_b(t1,t2,t3)-pi;
    case 6
        theta=cal_direction_b(t1,t2,t3)+pi;
    case 7
        theta=cal_direction_b(t1,t2,t3)+3*pi/2;
    case 8
        theta=cal_direction_b(t1,t2,t3)-pi/2;
end

theta = real(theta) / pi * 180

end





