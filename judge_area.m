function [t1, t2, t3, label]=judge_area(y1_init,fs)

t=1/fs;
if min(y1_init)~=0
    y1_init=y1_init-min(y1_init);
end

a=find(y1_init==0);
display(a);
len=length(a);

if len==1
    switch a 
        case 1
            [~,index]=find_2min(y1_init);
            if index==4
                label=1;
                t1=y1_init(4)*t;
                t2=y1_init(2)*t;
                t3=y1_init(3)*t;
            else
                label=2;
                t1=y1_init(2)*t;
                t2=y1_init(4)*t;
                t3=y1_init(3)*t;
            end
        case 2
            [~,index]=find_2min(y1_init);
            if index==1
                label=3;
                t1=y1_init(1)*t;
                t2=y1_init(3)*t;
                t3=y1_init(4)*t;
            else
                label=4;
                t1=y1_init(3)*t;
                t2=y1_init(1)*t;
                t3=y1_init(4)*t;
            end
        case 3
            [~,index]=find_2min(y1_init);
            if index==4
                label=6;
                t1=y1_init(4)*t;
                t2=y1_init(2)*t;
                t3=y1_init(1)*t;
            else
                label=5;
                t1=y1_init(2)*t;
                t2=y1_init(4)*t;
                t3=y1_init(1)*t;
            end
        case 4
            [~,index]=find_2min(y1_init);
            if index==3
                label=7;
                t1=y1_init(3)*t;
                t2=y1_init(1)*t;
                t3=y1_init(2)*t;
            else
                label=8;
                t1=y1_init(1)*t;
                t2=y1_init(3)*t;
                t3=y1_init(2)*t;
            end
    end
    
else       %四个坐标轴的情况
    if sum(a)== 3
        t1=0;
        label=2;
        t2=(y1_init(3)+y1_init(4))/2*t;
        t3=(y1_init(3)+y1_init(4))/2*t;
    elseif sum(a)==7
        t1=0;
        label=6;
        t2=(y1_init(1)+y1_init(2))/2*t;
        t3=(y1_init(1)+y1_init(2))/2*t;
    elseif a(1)==2
        t1=0;
        label=4;
        t2=(y1_init(1)+y1_init(4))/2*t;
        t3=(y1_init(1)+y1_init(4))/2*t;
    elseif a(1)==1||a(2)==4
        t1=0;
        label=8;
        t2=(y1_init(2)+y1_init(3))/2*t;
        t3=(y1_init(2)+y1_init(3))/2*t;
    end
end

end