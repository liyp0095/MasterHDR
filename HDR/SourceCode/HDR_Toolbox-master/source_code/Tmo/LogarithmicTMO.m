function imgOut = LogarithmicTMO(img, q_logarithmic, k_logarithmic)
%
%        imgOut = LogarithmicTMO(img, Log_scale)   
%
%
%       Input:
%           -img: input HDR image
%           -q_logarithmic: appearance value (1, +inf)
%           -k_logarithmic: appearance value (1, +inf)
%
%       Output
%           -imgOut: tone mapped image
% 
%     Copyright (C) 2006-2010 Francesco Banterle
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

check13Color(img);

if(~exist('q_logarithmic', 'var'))
    q_logarithmic = 1;
end

if(~exist('k_logarithmic', 'var'))
    k_logarithmic = 1;
end

%checking q_logarithmic >= 1
if(q_logarithmic < 1)
    q_logarithmic = 1;
end

%checking q_logarithmic >= 1
if(k_logarithmic < 1)
    k_logarithmic = 1;
end

%computing the luminance channel
L = lum(img);

%computing maximum luminance value
LMax = max(L(:));

%dynamic Range Reduction
Ld = log10(1 + L * q_logarithmic) / log10(1 + LMax * k_logarithmic);

%changing luminance
imgOut = ChangeLuminance(img, L, Ld);

end