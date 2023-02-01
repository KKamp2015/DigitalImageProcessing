%Housekeeping commands
clear all
close all

figure
a=imread('Drops.jpeg','jpeg'); %reading in image
a=im2gray(a); %Converting to Greyscale image
imagesc(a) %Duisplying image scaled
colormap('gray') %setting color map to grey
axis image off %turning off axis and image ascpect ratio
b=reshape(a,1,[]); % flatting the image to use later
L=double(max(b)); %taking the max value of image
figure %starting new figure
h1=histogram(b,'NumBins',L); %making histogram for the image
% setting labels
title('Histogram of Original Image')
xlabel('r')
ylabel('p(r)')
exportgraphics(gcf,'OGHist.png','Resolution',300)% saving image
MN=length(b);%getting number of pixels
counts=h1.Values;%getting number of pixles at each bin
T=round(cumsum(counts)/MN .*(L-1));%Creating equalizing transform
figure
plot(T) %plotting new transfrom
title('Transform for Image')
xlabel('r')
ylabel('T(r)')
exportgraphics(gcf,'TransformT.png','Resolution',300)
c=zeros(1,length(b));
%Replaceing each pixel to its transfromed value
for i=1:length(b)
    j=int8(b(i));
    c(i)=T(j+1);
end
figure
d=reshape(c,size(a)); %reshaping back to image size
imagesc(d)
axis image off
colormap('gray')
exportgraphics(gcf,'HistNorm.png','Resolution',300)

figure
h2=histogram(d,'NumBins',L); %displaing new histogram
title('Histogram of Equalized Image')
xlabel('r')
ylabel('p(r)')
exportgraphics(gcf,'New1Hist.png','Resolution',300)


pz=@(z) pi/(2*(L-1))*sin(z*pi/(L-1)); %histogram to match
G=zeros(1,L-1); %allocating memory
for i=1:length(G)
    G(i)=pz(i-1); %creating new transfrom for matching
end
G=round(cumsum(G).*(L-1)); %finishing new tranfrom
%transforming image to match histgram
e=zeros(1,length(b));
for i=1:length(b)
    j=int8(b(i));
    e(i)=G(j+1);
end
%reashping transfromed iamge
f=reshape(e,size(a));
figure
imagesc(f)
axis image off
colormap('gray')
exportgraphics(gcf,'HistMatchImage.png','Resolution',300)

%Making new histogram
figure
histogram(f,'NumBins',L)
title('Histogram of Matched Image')
xlabel('r')
ylabel('p(r)')
exportgraphics(gcf,'MatchedHist.png','Resolution',300)
