function L_adapt = ReinhardBilateralFiltering(L, pAlpha, pPhi, pEpsilon)  
%
%
%      L_adapt = ReinhardBilateralFiltering(L, pAlpha, pPhi, pEpsilon)  
%
%
%       Input:
%           -L: input grayscale image
%           -pAlpha: value of exposure of the image
%           -pPhi: a parameter which controls the sharpening
%           -pEpsilon: smoothing threshold
%
%       Output:
%           -L_adapt: filtered image
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

if(~exist('pAlpha', 'var'))
    pAlpha = ReinhardAlpha(L);
end

if(~exist('pPhi', 'var'))
    pPhi = 8;
end

if(~exist('pEpsilon', 'var'))
    pEpsilon = 0.05;%as in the original paper
end

sMax    = 8;     
alpha1  = (((2^pPhi) * pAlpha) / (sMax^2)) * pEpsilon;
alpha2  = round(1.6^sMax);    

L_tmp = L ./ (L + 1);
L_adapt = bilateralFilter(L_tmp, [], 0, 1, alpha2, alpha1);
L_adapt = L_adapt ./ (1 - L_adapt);

end