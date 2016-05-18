addpath('hdr_pics');
addpath('pics');

subplot(121);
hdr = imread('sat.png');
imshow(hdr);
hdr = im2single(hdr);
hdr = hdr/256;
subplot(122);
imshow(tonemap(hdr));

% a = ones(1000, 1000);
% a = a/2;
% imshow(a);