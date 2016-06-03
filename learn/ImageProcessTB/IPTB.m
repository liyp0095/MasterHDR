%% Basic Image Import, Processing, and Export

img = rgb2gray(imread('BasicImageImportProcessingAndExportExample_01.png'));
imshow(img);
whos img  % Check How the Image Appears in the Workspace
figure
imhist(img);

% Histogram equalization
img2 = histeq(img);
figure
imshow(img2);
figure
imhist(img2);

% Write the Adjusted Image to a Disk File
imwrite (img2, 'pout2.png');
imfinfo('pout2.png');

%% Basic Image Enhancement and Analysis Techniques

img = imread('BasicImageEnhancementAndAnalysisTechniquesExample_01.png');
img = rgb2gray(img);
imshow(img);

% Preprocess the Image to Enable Analysis
background = imopen(img, strel('disk',15));
imshow(background);

figure
surf(double(background(1:8:end,1:8:end))),zlim([0 255]); 
set(gca,'ydir','reverse');

img2 = img - background;
figure
imshow(img2)

img3 = imadjust(img2);
imshow(img3);

level = graythresh(img3);
bw = im2bw(img3,level);
bw = bwareaopen(bw, 50);
imshow(bw)

% Perform Analysis of Objects in the Image
cc = bwconncomp(bw, 4);
cc.NumObjects
grain = false(size(bw));
grain(cc.PixelIdxList{1}) = true;
imshow(grain);

figure
labeled = labelmatrix(cc);
RGB_label = label2rgb(labeled, @spring, 'c', 'shuffle');
imshow(RGB_label);

graindata = regionprops(cc, 'basic');
graindata(50).Area
grain_areas = [graindata.Area];
[min_area, idx] = min(grain_areas);
grain = false(size(bw));
grain(cc.PixelIdxList{idx}) = true;
imshow(grain);

% Using the hist command to create a histogram of rice grain areas.
nbins = 20;
figure, hist(grain_areas, nbins)
title('Histogram of Rice Grain Area');

%% import export and information
% map is color map, transparent is ...
[I, map, transparent] = imread('2.png');
image(I);
figure
imshow(I);
map
transparent
save data I
clear

% export
load data
imwrite(I, 'imwrite.png', 'Bitdepth', 16);
imwrite(I,'newImage.jpg','jpg','Comment','这是评论', 'quality', 10);
info = imfinfo('newImage.jpg');

imshow(imread('imwrite.png'));

% imread, imwrite, imfinfo

%% HDR
% hdrread hdrwrite makehdr tonemap % tonemap 有参数调整

a = {};

for i = 6360:6369
    a{i-6359} = strcat('IMG_', int2str(i), '.JPG');
end

mhdr = makehdr(a);
rgb = tonemap(mhdr);
figure; imshow(rgb)

%% Large image files
% Reduced Resolution Data Set for Very Large Images
% ImageAdapter

%% Image type conversion
% image type: Binary indexed Grayscale Truecolor
% rgb2gray() 

% Bayer-patterned 什么鬼？？？
% References
% [1] Malvar, H.S., L. He, and R. Cutler, High quality linear interpolation for demosaicing of Bayer-patterned color images. ICASPP, Volume 34, Issue 11, pp. 2274-2282, May 2004.

I = rgb2gray(imread('ConvertABayerEncodedImageExample_01.png'));
J = demosaic(I,'bggr');
imshow(I);
figure, imshow(J);

%% Image Sequences and Batch Processing
% Apps
% Image Batch Processor	Process folder of images
% Video Viewer	View videos and image sequences
% 
% Examples and How To
% Process Multi-Frame Image Arrays
% View Image Sequences in Video Viewer App
% Perform an Operation on a Sequence of Images
% Batch Processing Using the Image Batch Processor App
% Process Large Set of Images Using MapReduce Framework and Hadoop

% Concepts
% What Is an Image Sequence?
% Toolbox Functions That Work with Image Sequences

%% 





