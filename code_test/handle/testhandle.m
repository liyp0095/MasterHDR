function [ output ] = testhandle(  )
%TESTHANDLE ���Ժ������
%   �˴���ʾ��ϸ˵��
ahandle = @(x) x.*x;
otherhandle = @(x) 10 * sin(x);
li = 1:10;
[y1, y2] = abc(ahandle, otherhandle, li);

end

