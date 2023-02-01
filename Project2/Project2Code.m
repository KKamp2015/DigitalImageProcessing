%Housekeeping commands
clear all
close all

figure
a=imread('Drops.jpeg','jpeg'); %reading in image
a=im2gray(a);
imagesc(a)
colormap('gray')
axis image off
b=reshape(a,1,[]);
L=double(max(b));
figure
h1=histogram(b,'NumBins',L);
title('Histogram of Original Image')
xlabel('r')
ylabel('p(r)')
exportgraphics(gcf,'OGHist.png','Resolution',300)
MN=length(b);
counts=h1.Values;
T=round(cumsum(counts)/MN .*(L-1));
figure
plot(T)
title('Transform for Image')
xlabel('r')
ylabel('T(r)')
exportgraphics(gcf,'TransformT.png','Resolution',300)
c=zeros(1,length(b));
for i=1:length(b)
    j=int8(b(i));
    c(i)=T(j+1);
end
figure
d=reshape(c,size(a));
imagesc(d)
axis image off
colormap('gray')
exportgraphics(gcf,'HistNorm.png','Resolution',300)

figure
h2=histogram(d,'NumBins',L);
title('Histogram of Equalized Image')
xlabel('r')
ylabel('p(r)')
exportgraphics(gcf,'New1Hist.png','Resolution',300)
pz=@(z) pi/(2*(L-1))*sin(z*pi/(L-1));
G=zeros(1,L-1);
for i=1:length(G)
    G(i)=pz(i-1);
end
G=round(cumsum(G).*(L-1));
e=zeros(1,length(c));
for i=1:length(c)
    j=int8(b(i));
    e(i)=G(j+1);
end
f=reshape(e,size(a));
figure
imagesc(f)
axis image off
colormap('gray')
exportgraphics(gcf,'HistMatchImage.png','Resolution',300)
figure
histogram(f,'NumBins',L)
title('Histogram of Matched Image')
xlabel('r')
ylabel('p(r)')
exportgraphics(gcf,'MatchedHist.png','Resolution',300)
