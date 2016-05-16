function [ output ] = testhandle(  )
%TESTHANDLE 测试函数句柄
%   此处显示详细说明
ahandle = @(x) x.*x;
otherhandle = @(x) 10 * sin(x);
li = 1:10;
[y1, y2] = abc(ahandle, otherhandle, li);

end

