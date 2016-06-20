addpath('..\hdr_pics');

hdr = hdrread('Oxford_Church.hdr');
hdr = hdr./max(max(max(hdr)));

grayhdr = rgb2gray(hdr);
imhist(grayhdr);

X = grayhdr;
X = X(:);
% X = randn(1000, 1);

opts = statset('Display','final');

[Idx,Ctrs,SumD,D] = kmeans(X,2,'Replicates',2,'Options', opts);

plot(X(Idx==1,1),'r.','MarkerSize',1)
hold on
plot(X(Idx==2,1),'b.','MarkerSize',1)
% hold on
% plot(X(Idx==3,1),'g.','MarkerSize',1)
% hold on
% plot(X(Idx==4,1),'y.','MarkerSize',1)
% hold on
% plot(X(Idx==5,1),'m.','MarkerSize',1)
% hold on
% plot(X(Idx==6,1),'c.','MarkerSize',1)