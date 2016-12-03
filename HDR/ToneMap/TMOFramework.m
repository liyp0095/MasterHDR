check3Color(img);

L = lum(img);

imgOut = zeros(size(img));
for i = 1:3
    imgOut(:,:,i) = img(:,:,i) .* Ld ./ L;
end

imgOut = RemoveSpecials(imgOut);

%% tmo test

% church hdr
hdr = hdrread('.\hdr_pics\Oxford_Church.hdr');
% my hdr
% hdr = hdrread('..\hdr_pics\diffuse_map.hdr');
% hdr = hdrread('..\hdr_pics\dorm_mini.hdr');

tic;
% gammar TMO
subplot(231);
GammaTMO(hdr, 2.2, 0, 0.8);
toc;
t = toc;
title('GammaTMO');
text(0,-150,['time=',num2str(t)]);

tic;
% test adaptive logarithmic mapping 
subplot(232);
img = DragoTMO(hdr, 100, 0.5);
GammaTMO(img, 2.2, 0, 1);
subplot(233);
imgTMOCor = ColorCorrection(img, 1);
GammaTMO(imgTMOCor, 2.2, 0, 1);

toc;
t = toc;
title('DragoTMO');
text(0,-150,['time=',num2str(t)]);

tic
% quantization technique
subplot(234);
img = SchlickTMO(hdr, 'calib');
imshow(img);
toc
t = toc;
title('quantization');
text(0,-150,['time=',num2str(t)]);

tic
% broghtness reproduction
subplot(235);
img = TumblinRushmeierTMO(hdr, 30, 50);
GammaTMO(img, 2.2, 0, 1);
% GammaTMO(img, 2.2, 0, 1);
% imshow(img);
toc
t = toc;
title('Brightness');
text(0,-150,['time=',num2str(t)]);

tic
% a model of visual adaptation
subplot(236);
img = FerwerdaTMO(hdr, 100, 30, 0.05);
imshow(img);
toc
t = toc;
title('Visual adaptation FerwerdaTMO');
text(0,-150,['time=',num2str(t)]);

% WardHistAdjTMO
figure
img = WardHistAdjTMO(hdr, 4);
imshow(img);

% time-dependent visual adaptation
% nothing in the book

% encoding of high dynamic range video with a model of human cones
% the author does not provide any study on companding and further
% quantization for his TMO/iTMO

% 
%% 
% local TMO

% church hdr
hdr = hdrread('.\hdr_pics\Oxford_Church.hdr');

imgOut = AshikhminTMO(hdr, 80, true);
imshow(imgOut);

% figure
% imgOut = YeeTMO(hdr, 5, 100, 30);
% imshow(imgOut);






