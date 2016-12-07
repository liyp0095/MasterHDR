img = imread('..\pics\sat2.jpg');

img = double(img) ./ 256;
img = lum(img);
img = img ./ max(max(img));

figure, imshow(img);

% imgOut = AkyuzEO(img, 1000, 2.2, -1);
imgOut = HuoEO(img, 1/10000, 0.2);

figure, h = HistogramHDR(imgOut,50,'log10',[],0,1);

img = ReinhardTMO(imgOut);
figure, imshow(img);

figure, imshow(imgOut/1000);

max(max(imgOut))