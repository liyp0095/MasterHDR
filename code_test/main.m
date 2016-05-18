addpath('test');
addpath('handle');

testfun('testfile.txt', 1, 2);
testhandle();

%% 
path = 'file';

mydir = dir(path);
N = length(mydir);
filename = {mydir(3:end-1).name};

for i = 1:length(filename)
    inname = {};
    list = dir(fullfile(path, filename{i}, '*.jpg'));
    M = length(list);
    inname = {list(3:end).name};
%     for j = 1:M-2
%         % disp(fullfile(path, filename(i), list(j).name));
%         inname{j} = fullfile(path, filename(i), list(j).name);
%     end
    addpath([path '\' filename{i}]);
    hdr = makehdr(inname);
    hdrwrite(hdr, 'one.hdr');
end 
