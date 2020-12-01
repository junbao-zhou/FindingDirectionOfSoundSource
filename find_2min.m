function [b,j]=find_2min(x)
x_1=x;
[~,i]=min(x_1);
x_1(i)=max(x_1);
[b,j]=min(x_1);
end
