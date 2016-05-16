%% HDR
a = {};

for i = 6360:6369
    a{i-6359} = strcat('IMG_', int2str(i), '.JPG');
end

mhdr = makehdr(a);
rgb = tonemap(mhdr);
figure; imshow(rgb)

