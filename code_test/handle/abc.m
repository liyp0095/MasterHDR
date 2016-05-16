function [ y1, y2 ] = abc( fun1, fun2, li )
%ABC 用来给两个函数画图
%   此处显示详细说明
y1 = fun1(li);
y2 = fun2(li);

plot(y1, 'ro');
hold on;
plot(y2, 'go');

end

