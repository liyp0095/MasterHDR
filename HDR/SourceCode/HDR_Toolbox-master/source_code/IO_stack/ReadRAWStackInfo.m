function exposure = ReadRAWStackInfo(dir_name, format)
%
%       exposure = ReadRAWStackInfo(dir_name, format)
%
%
%        Input:
%           -dir_name: the folder name where the stack is stored.
%           -format: a RAW format for reading MDR images.
%
%        Output:
%           -exposure: an array of exposure values from images in dir_name
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

list = dir([dir_name, '/*.', format]);
n = length(list);
exposure = zeros(n, 1);

for i=1:n
    try
        img_info = read_raw_info([dir_name, '/', list(i).name]);
        
        exposure_time = img_info.ExposureTime;
        aperture = img_info.FNumber;
        iso = img_info.ISOSpeedRatings;

        [~, value] = EstimateAverageLuminance(exposure_time, aperture, iso);
        exposure(i) = value;
    
    catch expr
        disp(expr);        
    end
end

end