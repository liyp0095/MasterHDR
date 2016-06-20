addpath('..\hdr_pics');

hdr = hdrread('hdr_image.hdr');
pic = tonemap(hdr);

imshow(pic);

%%

stack = ReadLDRStack(, 'jpg');