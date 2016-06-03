function HDRJPEG2000Enc(img, name, compRatio)
%
%
%       HDRJPEG2000Enc(img, name, compRatio)
%
%
%       Input:
%           -img: HDR image
%           -name:  is output name of the image
%           -compRatio: is JPEG output quality in [1, +inf]
%
%     Copyright (C) 2011-2015  Francesco Banterle
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

if(~exist('name', 'var'))
    name = 'test_hdrjpeg2000';
end

if(~exist('compRatio', 'var'))
    compRatio = 2;
end

if(compRatio < 1)
    compRatio = 1;
end

delta = 1e-6;

%Range reduction
nBit = 16;
imgLog = log(img + delta);
xMin = zeros(3, 1);
xMax = zeros(3, 1);
col = size(img, 3);
for i = 1:col
    xMin(i) = min(min(imgLog(:,:,i)));
    xMax(i) = max(max(imgLog(:,:,i)));
    imgLog(:,:,i) = (imgLog(:,:,i) - xMin(i)) / (xMax(i) - xMin(i));
end
imgLog = uint16(imgLog * (2^nBit - 1));

%metadata string
metadata = [];
for i = 1:col
    metadata = [metadata, num2str(xMax(i)), ' ', num2str(xMin(i)), ' '];
end

imwrite(imgLog, [name,'.jp2'], 'CompressionRatio', compRatio, 'mode', 'lossy', 'Comment', metadata);
end