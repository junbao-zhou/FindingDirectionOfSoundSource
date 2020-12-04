clc;clear all; close all;

sound_index = 1;
is_plot = false;
is_filter = true;

load train/angle.txt

path = './train/';

for sound_index = 1:14

% 数据录入
y = [];
for i = 1:4
    [y(i,:),fs]=audioread([path,num2str(sound_index),'_mic',num2str(i),'.wav']);
    if is_filter
%         f_y = fft(y(i,:));
%         stop_index = 2400 / fs * length(f_y);
%         f_y(stop_index: end - stop_index) = 0;
%         y(i,:) = ifft(f_y);
    y(i,:) = filter( normalize(ones(1,7),'norm',1), 1, y(i,:));
    end
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


%% correlate
t_delay = [0 find_delay(y(1,:),y(2,:)) find_delay(y(1,:),y(3,:)) find_delay(y(1,:),y(4,:))] / fs;

%% gccphat
% t_delay = [0 gccphat(y(2,:)',y(1,:)',fs) gccphat(y(3,:)',y(1,:)',fs) gccphat(y(4,:)',y(1,:)',fs)];

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

f_result = fopen([path,'result.txt'],'w');
fprintf(f_result,'%d\n',theta_record);
fclose(f_result);

err = theta_record - angle;
err = mod(err,360);
err = err - 360 * (err>180);

abse = mean(abs(err))

