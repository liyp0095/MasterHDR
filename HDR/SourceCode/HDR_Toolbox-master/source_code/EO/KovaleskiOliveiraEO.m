function [imgOut, bef_map] = KovaleskiOliveiraEO(img, type_content, KO_sigma_s, KO_sigma_r, KO_display_min, KO_display_max, gammaRemoval)
%
%       [imgOut, bef_map] = KovaleskiOliveiraEO(img, KO_sigma_s, KO_sigma_r, KO_display_min, KO_display_max, gammaRemoval)
%
%
%        Input:
%           -img: input LDR image with values in [0,1]
%           -type_content: -'image' if img is a still image
%                          -'video' if img is a frame of a video 
%           -KO_sigma_s: spatial sigma of the bilateral filter. Default for
%           HD content is 150.
%           -KO_sigma_r: range sigma of the bilateral filter. Default is
%           25/255.
%           -KO_display_min: black level of the display. Default is 0.3nit
%           -KO_display_max: white level of the display. Default is 1200nit
%           -gammaRemoval: the gamma value to be removed if known.
%
%        Output:
%           -imgOut: an expanded image.
%           -bef_map: the brightness expansion function.
%
%     Copyright (C) 2015  Francesco Banterle
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
%     "High-Quality Reverse Tone Mapping for a Wide Range of Exposures"
%     by Rafael P. Kovaleski and Manuel M. Oliveira, 
%     in 2014 27th SIBGRAPI Conference on Graphics, Patterns and Images
%


%is it a three color channels image?
check13Color(img);

if(~exist('KO_sigma_s', 'var'))
    KO_sigma_s = 150; %as in the original paper
end

if(~exist('KO_sigma_r', 'var'))
    KO_sigma_r = 25 / 255; %as in the original paper
end

if(~exist('type_content', 'var'))
    type_content = 'image';
end

if(~exist('KO_display_min', 'var'))
    KO_display_min = 0.3; %as in the original paper
end

if(~exist('KO_display_max', 'var'))
    KO_display_max = 1200; %as in the original paper
end

if(~exist('gammaRemoval', 'var'))
    gammaRemoval = 2.2;
end

switch type_content
    case 'video'
        threshold = 230 / 255;
    case 'image'
        threshold = 254 / 255;
    otherwise
        threshold = 230 / 255;
end

if(gammaRemoval > 0.0)
    img = img.^gammaRemoval;
    threshold = threshold^gammaRemoval;
    KO_sigma_r = KO_sigma_r^gammaRemoval;
end

imgA = max(img, [], size(img,3));

imgB = lum(img);

imgC = zeros(size(imgA));
imgC(imgA > threshold) = 1;

bef_map = bilateralFilter(imgC, imgB, 0, 1, KO_sigma_s, KO_sigma_r);

%remapping bef_map [1, ..., alpha]
alpha = 4.0;
bef_map = bef_map * (alpha - 1) + 1;

%scaling the final luminance
img_exp = img * (KO_display_max - KO_display_min) + KO_display_min;

%Removing the old luminance
imgOut = zeros(size(img));
for i=1:size(img,3)
    imgOut(:,:,i) = img_exp(:,:,i) .* bef_map;
end

end
