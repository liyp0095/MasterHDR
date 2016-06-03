function same = CheckSameImage(Img1, Img2)
%
%
%       same = CheckSameImage(Img1, Img2)
%
%
%       This image checks if two images are the same.
%
%     Copyright (C) 2011  Francesco Banterle
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

[r1, c1, col1] = size(Img1);
[r2, c2, col2] = size(Img2);

same = ((r1 == r2) & (c1 == c2) & (col1 == col2));

end