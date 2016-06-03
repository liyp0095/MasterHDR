function AnyCodecHDRvDec(hdrv, name)
%
%
%       AnyCodedHDRvDec(hdrv, name)
%
%       This function decodes HDRv streams
%
%       Input:
%           -hdrv: an HDR video stream, use hdrvread for opening a stream
%           -name: this is the output name of the decoded stream as single
%           hdr frames. For example, name = 'output.pfm' will save the hdr);v
%           as .pfm files, or name = 'output.hdr', will save the hdrv as
%           .hdr files
%
%     Copyright (C) 2013-14  Francesco Banterle
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
%     "RATE-DISTORTION OPTIMIZED COMPRESSION OF HIGH DYNAMIC RANGE VIDEOS"
% 	  by Chul Lee and Chang-Su Kim
%     in 16th European Signal Processing Conference (EUSIPCO 2008),
%     Lausanne, Switzerland, August 25-29, 2008, copyright by EURASIP
%
%

hdrv = hdrvopen(hdrv, 'r');

name = RemoveExt(filenameOutput);
ext  = fileExtension(filenameOutput);

for i=1:hdrv.totalFrames
    disp(['Processing frame ', num2str(i)]);
    
    %getting the current HDR frame
    [frame, hdrv] = hdrvGetFrame(hdrv, i);

    %saving the frame    
    hdrimwrite(frame, [name, sprintf('%.10d',i), '.', ext]);
end

hdrvclose(hdrv);

end
