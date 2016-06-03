function [frameOut, y, param_a, param_b] = ZhangFrameEnc(frame, n_bits)
%
%
%       frameOut = ZhangFrameEnc(img, n_bits)
%
%
%       Input:
%           -frame: input HDR frame
%           -n_bits: number of bits for quantization
%
%       Output:
%           -frameOut: frame to be
%           -y: encoding look-up table
%           -param_a: adaptive multiplicative parameter
%           -param_b: adaptive additive parameter
%
%     Copyright (C) 2013-2014  Francesco Banterle
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

if(~exist('n_bits','var'))
    n_bits = 8;
end

[frameOut, param_a, param_b] = float2ALogLuv(frame, 16);
L = round(frameOut(:,:,1));

[y, Y_min, Y_max] = ZhangQuantization(L, n_bits);

[r,c] = size(L);
n = r * c;

%applying look-up table
for i=1:n
    delta = abs(y - L(i));
    [value, index] = min(delta(:));
    L(i) = index;    
end

%Computing DWT2 transform
filterType = 'db3';
pyr  = dwt2Decomposition(L,  filterType, 5);
%Filtering the pyramid
pyr = ZhangDWTScaling(pyr);
%Reconstruction 
L_denoised = round(dwt2Reconstruction(pyr, filterType));

frameOut(:,:,1) = L_denoised;

end