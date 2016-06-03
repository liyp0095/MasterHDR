function fstops = ExposureHistogramCovering(img, nBin, eh_overlap)
%
%
%        fstops = ExposureHistogramCovering(img, nBin)
%
%
%        Input:
%           -img: input HDR image
%
%        Output:
%           -fstops: a set of fstops values covering the HDR image
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

if(~exist('nBin', 'var'))
    nBin = 1024;
end

if(~exist('eh_overlap', 'var'))
    eh_overlap = 1.0;
end

[histo, bound, ~] = HistogramHDR(img, nBin, 'log2', [], 0, 0);

dMM = (bound(2) - bound(1)) / nBin;
removingBins = round((4.0 - eh_overlap) / dMM);

fstops = [];
while(sum(histo) > 0)
    [~, ind] = max(histo);
    indMin = max([(ind - removingBins), 1]);
    indMax = min([(ind + removingBins), nBin]);
    histo(indMin:indMax) = 0;
    fstops = [fstops, (-(ind * dMM + bound(1)) - 1.0)];
end

end