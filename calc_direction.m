function theta = calc_direction(distance)

theta(1)=acos(distance(1)/(sqrt(2)*0.1))-pi/4;

theta(2)=-acos(distance(2)/(sqrt(2)*0.1))+pi/4;

theta(3)=acos(distance(3)/0.2);

theta=mean(theta);
%theta=theta_3;
end