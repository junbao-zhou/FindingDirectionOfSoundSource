function [t1, t2, t3, min_index, diff]=judge_area(y1_init,fs)

t=1/fs;
if min(y1_init)~=0
    y1_init=y1_init-min(y1_init);
end

[~,min_index] = min(y1_init);
[~,second_min_index] = find_2min(y1_init);
% display(a);

diff = mod(mod(min_index,4) - mod(second_min_index,4),4);

t_sorted = sort(y1_init);

t_sorted = t_sorted * t;

t1 = t_sorted(2);
t2 = t_sorted(3);
t3 = t_sorted(4);

end