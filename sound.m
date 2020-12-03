clc;clear all; close all;

sound_index = 1;
is_plot = false;

standard_angle =  [
   3.1500000e+02,
   3.5800000e+02,
   1.0700000e+02,
   1.5400000e+02,
   4.8000000e+01,
   2.0100000e+02,
   3.0300000e+02,
   8.4000000e+01,
   1.1900000e+02,
   3.4900000e+02,
   2.1800000e+02,
   1.0700000e+02,
   2.9700000e+02,
   1.0900000e+02]

for sound_index = 1:14

% 数据录入
path = './train';
y = [];
for i = 1:4
    [y(i,:),fs]=audioread(['train/',num2str(sound_index),'_mic',num2str(i),'.wav']);
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

% % pre
% pre_emphasis=0.97;
% y_pre = [];
% for i = 1:4
%     y_pre(i,:)=filter([1,-pre_emphasis],1,y(i,:));
% end
% 
% %draw post-pre 
% if is_plot
%     figure(2);
%     for i = 1:4
%         subplot(2,2,i);
%         stem(t,y_pre(i,:));
%     end
% end
% 
% y_pre_norm = y_pre*1.0./max(y_pre,[],2);
% %figure(3);
% %stem(t,y1_pre);
%  
% %找起始点：
% y_init=[find(y_pre_norm(1,:),1) find(y_pre_norm(2,:),1) find(y_pre_norm(3,:),1) find(y_pre_norm(4,:),1)];

%% correlate
% t_delay = [0 find_delay(y(1,:),y(2,:)) find_delay(y(1,:),y(3,:)) find_delay(y(1,:),y(4,:))] / fs;

%% gccphat
t_delay = [0 gccphat(y(2,:)',y(1,:)',fs) gccphat(y(3,:)',y(1,:)',fs) gccphat(y(4,:)',y(1,:)',fs)];

%%

%判定使用区域： judge_area()函数
[t1, t2, t3, min_index, diff] = judge_area(t_delay);

c = 343;
distance = [t1, t2, t3] * c;

theta = calc_direction(distance);

if diff == 1
    theta = -theta;
end

theta = theta + (min_index - 1) * pi / 2;

theta = real(theta) / pi * 180;
theta_record(sound_index) = mod(theta,360);

end


theta_record = theta_record'

err = theta_record - standard_angle;
err = mod(err,360);
err = err - 360 * (err>180);

abse = mean(abs(err))

