%Housekeeping commands
clear all
close all

%Part 1
x=randi([1,512],1,20);
y=randi([1,512],1,20);
points=zeros([512,512]);
for i=1:20
    points(x(i),y(i))=255;
end
ramp=imread('ramp.png','png'); %reading in image
ramp=im2gray(ramp);

bCorr=filter2(ramp,points);
imagesc(bCorr)
colormap('gray')
title('Correlation')
axis off image
exportgraphics(gcf,'Correlation.png','Resolution',300)
figure

cConv=conv2(points,ramp, 'same'); 
imagesc(cConv)
colormap('gray')
title('Convolution')
axis off image
exportgraphics(gcf,'Convolution.png','Resolution',300)

%PArt2
words=im2gray(imread("Text.png"));

w=im2gray(imread('w.png'));

textcorr=filter2(w,words);
figure
imagesc(textcorr)
colormap('gray')
axis off image
title('Text Correlation')
exportgraphics(gcf,'TextCorr.png','Resolution',300)

NormFilter=ones(size(w));
NormFilter=1/sum(NormFilter,'all') .* NormFilter;
NormConv=conv2(textcorr,NormFilter,'same');
Norm=textcorr./NormConv;
figure
imagesc(Norm)
colormap('gray')
axis off image
title('Normailized Text Correlation')
exportgraphics(gcf,'NormTextCorr.png','Resolution',300)
%Part3

a=imread('Drops.jpeg','jpeg'); %reading in image
a=im2gray(a); %Converting to Greyscale image

noise=uint8(floor(randn(256).*20+20)); %making noise array
b=a+noise; %adding noise to original image

sobx=[1 0 -1;2 0 -2;1 0 -1];
edges=filter2(sobx,b,"valid");
figure
imagesc(edges)
colormap('gray')
axis off image
title('Sobel x Edge Detection')
exportgraphics(gcf,'SobelXDrops.png','Resolution',300)

uni=ones(3);
uni=1/sum(uni,'all') * uni;
uniDrops=filter2(uni,b,'valid');
uniDropsEdge=filter2(sobx,uniDrops,'valid');
figure
imagesc(uniDropsEdge)
colormap('gray')
axis off image
title('Sobel x Edge Detection prepossessed with Uniform Filter')
exportgraphics(gcf,'UniSobelXDrops.png','Resolution',300)

Gauss=1/16 .* [1 2 1;2 4 2;1 2 1];
GaussDrops=filter2(Gauss,b,'valid');
GaussDropsEdge=filter2(sobx,GaussDrops,'valid');
figure
imagesc(GaussDropsEdge)
colormap('gray')
axis off image
title('Sobel x Edge Detection prepossessed with Gausian Filter')
exportgraphics(gcf,'GaussSobelXDrops.png','Resolution',300)
