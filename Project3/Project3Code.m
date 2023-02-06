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

figure

cConv=conv2(points,ramp, 'same'); 
imagesc(cConv)
colormap('gray')
title('Convolution')
axis off image

words=im2gray(imread("Text.png"));

w=im2gray(imread('w.png'));

textcorr=filter2(w,words);
figure
imagesc(textcorr)
colormap('gray')
axis off image

NormFilter=ones(size(w));
NormFilter=1/sum(NormFilter,'all') .* NormFilter;

NormConv=conv2(textcorr,NormFilter,'same');

Norm=textcorr./NormConv;

figure
imagesc(Norm)
colormap('gray')
axis off image
%Part3

a=imread('Drops.jpeg','jpeg'); %reading in image
a=im2gray(a); %Converting to Greyscale image

noise=uint8(floor(randn(256).*20+20)); %making noise array
b=a+noise; %adding noise to original image

sobx=[1 0 -1;2 0 -2;1 0 -1];
edges=filter2(sobx,b);
figure
imagesc(edges)
colormap('gray')
axis off image

uni=ones(5);
uni=1/sum(uni,'all') * uni;

uniDrops=filter2(uni,b,'valid');
figure
imagesc(uniDrops)
colormap('gray')
axis off image

x1 = -2:1:2;
x2 = -2:1:2;
[X1,X2] = meshgrid(x1,x2);
X = [X1(:) X2(:)];

y = mvnpdf(X,3,7);
y = reshape(y,length(x2),length(x1));

GaussDrops=filter2(y,b,'valid');
figure
imagesc(GaussDrops)
colormap('gray')
axis off image

