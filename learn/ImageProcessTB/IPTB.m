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

%% 