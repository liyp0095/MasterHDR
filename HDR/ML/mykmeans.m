%% kmeans cluster

X = [randn(100, 2)+ones(100,2).*0.5; randn(100,2)-ones(100,2).*0.5];
opts = statset('Display', 'final');
[idx, ctrs] = kmeans(X,4,'Distance','city','Replicates',5,'Options',opts);

plot(X(idx==1,1),X(idx==1,2),'r.','MarkerSize',12)
hold on
plot(X(idx==2,1),X(idx==2,2),'b.','MarkerSize',12)
plot(X(idx==3,1),X(idx==3,2),'y.','MarkerSize',12)
plot(X(idx==4,1),X(idx==4,2),'g.','MarkerSize',12)
plot(ctrs(:,1),ctrs(:,2),'kx','MarkerSize',12,'LineWidth',2)
plot(ctrs(:,1),ctrs(:,2),'ko','MarkerSize',12,'LineWidth',2)
legend('Cluster 1','Cluster 2','Centroids','Location','NW')

%% hdr kmeans cluster 

h = hdrread('.\hdr_pics\Oxford_Church.hdr');
imshow(h);
figure;
lh_small = imresize(lum(h), 1/8);
[m, n] = size(lh_small);

Y = reshape(lh_small, m*n, 1);
opts = statset('Display', 'final');
[idx, ctrs] = kmeans(Y,3,'Distance','city','Replicates',3,'Options',opts);
im = reshape(idx, m, n);
imshow(im/3);

%% nothing

plot(Y(idx==1,1),'r.','MarkerSize',2)
hold on
plot(Y(idx==2,1),'b.','MarkerSize',2)
plot(Y(idx==3,1),'y.','MarkerSize',2)
% plot(Y(idx==2,1),Y(idx==2,2),'b.','MarkerSize',12)
% plot(ctrs(:,1),ctrs(:,2),'kx','MarkerSize',12,'LineWidth',2)
% plot(ctrs(:,1),ctrs(:,2),'ko','MarkerSize',12,'LineWidth',2)
% legend('Cluster 1','Cluster 2','Centroids','Location','NW')

%% hdr hist()

h = hdrread('.\hdr_pics\Oxford_Church.hdr');
lh_small = imresize(lum(h), 1/8);
imshow(lh_small);
[m, n] = size(lh_small);
hs = GammaTMO(lh_small, 2.2, 0, 1);

Y = reshape(hs, m*n, 1);
hist(Y, 2000);

figure
imshow(hs)

%% hdr kmeans cluster gamma

h = hdrread('.\hdr_pics\Oxford_Church.hdr');
imshow(h);
figure;
lh_small = imresize(lum(h), 1/8);
% lh_small = h;
[m, n] = size(lh_small);

Y = reshape(lh_small, m*n, 1);
opts = statset('Display', 'final');
[idx, ctrs] = kmeans(Y,3,'Distance','city','Replicates',3,'Options',opts);
im = reshape(idx, m, n);
imshow(im/3);

[hm, hn, hl] = size(h);
lh_large = imresize(im, [hm, hn]);
figure, imshow(lh_large/3);

zs = repmat(lh_large, 1, 1, 3);
zs = round(zs);

h1 = h;
h1(zs == 2) = 0;
h1(zs == 3) = 0;
hs1 = GammaTMO(h1, 2.2, 0, 1);
figure, imshow(hs1);

h2 = h;
h2(zs == 1) = 0;
h2(zs == 3) = 0;
hs2 = GammaTMO(h2, 2.2, 0, 1);
figure, imshow(hs2);

h3 = h;
h3(zs == 1) = 0;
h3(zs == 2) = 0;
hs3 = GammaTMO(h3, 2.2, 0, 1);
figure, imshow(h3);

figure, imshow(h);

%% kmeans two channal 

h = hdrread('.\hdr_pics\Oxford_Church.hdr');
h = GammaTMO(h, 2.2, 0, 1);
imshow(h);
figure;
hr = h(:,:,1);
hg = h(:,:,1);
hb = h(:,:,1);
hrs = imresize(hr, 1/16);
hgs = imresize(hg, 1/16);
hbs = imresize(hb, 1/16);

[m, n] = size(hrs);

rline = reshape(hrs, m*n, 1);
gline = reshape(hgs, m*n, 1);
bline = reshape(hbs, m*n, 1);

X = [rline gline bline];

imshow(hrs);
figure, histogram(hbs, 500);


%%
% kmeans and draw
opts = statset('Display', 'final');
[idx, ctrs] = kmeans(X,2,'Distance','city','Replicates',5,'Options',opts);
plot(X(idx==1,1),X(idx==1,2),'r.','MarkerSize',4)
hold on
plot(X(idx==2,1),X(idx==2,2),'b.','MarkerSize',4)
% plot(X(idx==3,1),X(idx==3,2),'y.','MarkerSize',4)
% plot(X(idx==4,1),X(idx==4,2),'g.','MarkerSize',4)
plot(ctrs(:,1),ctrs(:,2),'kx','MarkerSize',12,'LineWidth',2)
plot(ctrs(:,1),ctrs(:,2),'ko','MarkerSize',12,'LineWidth',2)
legend('Cluster 1','Cluster 2','Centroids','Location','NW')

figure, hist(hr, 200);
