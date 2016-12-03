name_folder = '..\pics\dorm';
format = 'png';

disp('1) Reading LDR images');
stack = ReadLDRStack(name_folder, format);

disp('2) Read exposure values from the exif');
% ex = ReadLDRStackInfo(name_folder, format);
ex = [1, 1/2, 1/4, 1/8, 1/15, 1/30, 1/60, 1/125, 1/250, 1/500, 1/1000, 1/2000, 1/4000];

disp('3) Estimate the Camera Response Function (CRF)');
[lin_fun, ~] = ComputeCRF(stack, ex, 512, NaN, false);    
h = figure(1);
set(h, 'Name', 'The Camera Response Function (CRF)');
plot(lin_fun);

disp('4) Build the radiance map using the stack and stack_exposure');
imgHDR = BuildHDR(stack, ex, 'LUT', lin_fun, 'Deb97', 'log');

disp('5) Save the radiance map in the .hdr format');
hdrimwrite(imgHDR, '..\hdr_pics\dorm_mini.hdr');

disp('6) Show the tone mapped version of the radiance map with gamma encoding');
h = figure(2);
set(h, 'Name', 'Tone mapped version of the built HDR image');
GammaTMO(ReinhardTMO(imgHDR, 0.18), 2.2, 0, 1);
