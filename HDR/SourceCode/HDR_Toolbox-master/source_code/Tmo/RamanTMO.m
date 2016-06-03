function imgOut = RamanTMO( img, folder_name, format, imageStack)
%
%
%        imgOut = RamanTMO( img, folder_name, format, imageStack)
%
%
%        Input:
%           -img: input HDR image
%           -folder_name: the folder where to fetch the exposure imageStack in
%           the case img=[]
%           -format: the format of LDR images ('bmp', 'jpg', etc) in case
%                    img=[] and the tone mapped images is built from a sequence of
%                    images in the current folder_name
%           -imageStack: an exposure stack of LDR images; in case img=[],
%                        and folder_name='' and format=''
%
%        Output:
%           -imgOut: tone mapped image
%
%        Note: Gamma correction is not needed because it works on gamma
%        corrected images.
% 
%     Copyright (C) 2012-15  Francesco Banterle
%
%     This program is free software: you can redistribute it and/or modify
%     it under the terms of the GNU General Public License as published by
%     the Free Software Foundation, either version 3 of the License, or
%     (at your option) any later version.
% 
%     This program is distributed in the hope that it will be useful,
%     but WITHOUT ANY WARRANTY; without even the implied warranty of
%     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%     GNU General Public License for more details.
% 
%     You should have received a copy of the GNU General Public License
%     along with this program.  If not, see <http://www.gnu.org/licenses/>.
%
%     The paper describing this technique is:
%     "Bilateral Filter Based Compositing for Variable Exposure Photography"
% 	  by Shanmuganathan Raman and Subhasis Chaudhuri
%     in Eurographics 2009 Short papers program
%

%imageStack generation
if(~exist('imageStack', 'var'))
    imageStack = [];
end

if(~isempty(img))
    %Convert the HDR image into a imageStack
    [imageStack, ~] = GenerateExposureBracketing(img, 1);
else
    if(isempty(imageStack))
        imageStack = double(ReadLDRStack(folder_name, format, 1));    
    else
        if(isa(imageStack, 'single'))
            imageStack = double(imageStack);
        end
        
        if(isa(imageStack, 'uint8'))
            imageStack = double(imageStack) / 255.0;
        end
        
        if(isa(imageStack, 'uint16'))
            imageStack = double(imageStack) / 655535.0;
        end        
    end
end

C = 70.0 / 255.0; %As reported in Raman and Chaudhuri Eurographics 2009 short paper

%number of images in the imageStack
[r, c, col, n] = size(imageStack);

K1 = 1.0; %As reported in Raman and Chaudhuri Eurographics 2009 short paper
K2 = 1.0 / 10.0; %As reported in Raman and Chaudhuri Eurographics 2009 short paper
sigma_s = K1 * min([r, c]);
imageStackMax = max(imageStack(:));
imageStackMin = min(imageStack(:));
sigma_r = K2 * (imageStackMax - imageStackMin);

%Computation of weights for each image
total = zeros(r, c);
weight = zeros(r, c, n);
for i=1:n
    L = lum(imageStack(:,:,:,i));
    L_filtered = bilateralFilter(L, [], imageStackMin, imageStackMax, sigma_s, sigma_r);
    weight(:,:,i) = C + abs(L - L_filtered);
    total = total + weight(:,:,i);
end

%merging
imgOut = zeros(r, c, col);
for i=1:n
    for j=1:col
        tmp = imageStack(:,:,j,i) .* weight(:,:,i) ./ total;
        imgOut(:,:,j) = imgOut(:,:,j) + RemoveSpecials(tmp);
    end
end

%Clamping
imgOut = ClampImg(imgOut, 0.0, 1.0);

disp('WARNING: this algorithm outputs images with gamma encoding. Inverse gamma is not required to be applied.');

end