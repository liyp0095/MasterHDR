path = 'mysource/qinshi_middle';

% find all JPEG or PPM files in directory
files = dir([path '/*.jpg']);
N = length(files);
if (N == 0)
    files = dir([path '/*.png']);
    N = length(files);
    if (N == 0)
        error('no files found');
    end
end

%% allocate memory
sz = size(imread([path '/' files(1).name]));
r = sz(1);
c = sz(2);
I = zeros(r,c,N);
trainset_x = zeros(r*c, N);

%% read all files
for i = 1:N
    
    % load image
    filename = [path '/' files(i).name];
    im = double(imread(filename)) / 255;
    if (size(im,1) ~= sz(1) || size(im,2) ~= sz(2))
        error('images must all have the same size');
    end
    
    % optional downsampling step
%     if (reduce < 1)
%         im = imresize(im,[r c],'bicubic');
%     end
    
    im = rgb2gray(im);
    I(:,:,i) = im(:,:,1);
    im = im(:,:,1);
    
    trainset_x(:,i) = im(:);

end

yim = rgb2gray(double(imread('qinshi_middle.jpg'))/255);
trainset_y = yim(:);

% normalize
% [trainset_x, mu, sigma] = zscore(trainset_x);
% test_x = normalize(test_x, mu, sigma);

rand('state',0);

nn = nnsetup([13 1]);

nn.activation_function = 'sigm';    %  Sigmoid activation function
nn.learningRate = 1;                %  Sigm require a lower learning rate
nn.weightPenaltyL2 = 1e-4;  %  L2 weight decay
opts.numepochs =  1;   %  Number of full sweeps through data
opts.batchsize = 32;  %  Take a mean gradient step over this many samples
[nn, L] = nntrain(nn, trainset_x, trainset_y, opts);

%%
% trainset_x;
im_out = zeros(r, c);
x = zeros(1,13);
% for i = 1:r
%     for j = 1:c
%         x(:) = I(i, j, :);
%         x = x - 0.5;
%         nn = nnff(nn, x, zeros(size(x,1), nn.size(end)));
%         im_out(i,j) = nn.a{end};
%     end
% end

lout = zeros(r*c, 1);
for i = 1:r*c
    x(:) = trainset_x(i,:);
    nn = nnff(nn, x, zeros(size(x,1), nn.size(end)));
    lout(i) = nn.a{end};
end
im_out = reshape(lout, r, c);

subplot(121);
imshow(yim)
subplot(122);
imshow(im_out);