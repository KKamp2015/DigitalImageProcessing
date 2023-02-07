%Housekeeping commands
clear all
close all

%Part 1
x=randi([1,512],1,20); %Picking 20 random x values
y=randi([1,512],1,20); %Picking 20 random y values
points=zeros([512,512]); %memory allocation
for i=1:20
    points(x(i),y(i))=255; %assigning the random x,y to 255
end
%Displaying image
imagesc(points)
colormap('gray')
title('Points')
axis off image
exportgraphics(gcf,'Points.png','Resolution',300)

%reading in ramp
ramp=imread('ramp.png','png'); %reading in image
ramp=im2gray(ramp); %converting to grayscale

bCorr=filter2(ramp,points); %performing correlation
%displaying Correlation result
figure
imagesc(bCorr)
colormap('gray')
title('Correlation')
axis off image
exportgraphics(gcf,'Correlation.png','Resolution',300)


cConv=conv2(points,ramp, 'same'); %perfroming convolution
%Displaying Convolution result
figure
imagesc(cConv)
colormap('gray')
title('Convolution')
axis off image
exportgraphics(gcf,'Convolution.png','Resolution',300)

%Part2
words=im2gray(imread("Text.png"));%reading in text image

w=im2gray(imread('w.png'));%reading in w image

textcorr=filter2(w,words); %performing correlation
%displaying Correlation Result
figure
imagesc(textcorr)
colormap('gray')
axis off image
title('Text Correlation')
datacursormode('on')
exportgraphics(gcf,'TextCorr.png','Resolution',300)

%Perfroming Normalzination
NormFilter=ones(size(w)); %memory allocation
NormFilter=1/sum(NormFilter,'all').*NormFilter;%making normalization kernal
NormConv=conv2(textcorr,NormFilter,'same');%performing filter normztion
Norm=textcorr./NormConv; %dividing by normailed filter image
%displaying normalziation resutl
figure
imagesc(Norm)
colormap('gray')
axis off image
title('Normailized Text Correlation')
datacursormode('on')
exportgraphics(gcf,'NormTextCorr.png','Resolution',300)


%Part3
a=imread('Drops.jpeg','jpeg'); %reading in image
a=im2gray(a); %Converting to Greyscale image

noise=uint8(floor(randn(256).*20+20)); %making noise array
b=a+noise; %adding noise to original image
%
figure
imagesc(b)
colormap('gray')
axis off image
title('Noisy')
exportgraphics(gcf,'Noisy.png','Resolution',300)

sobx=[1 0 -1;2 0 -2;1 0 -1]; %Creating Sobel opperator
edges=filter2(sobx,b,"valid"); %Perfroming sobel edge finder
%Displaying results
figure
imagesc(edges)
colormap('gray')
axis off image
title('Sobel x Edge Detection')
exportgraphics(gcf,'SobelXDrops.png','Resolution',300)

%creating unifomr filter
uni=ones(3); 
uni=1/sum(uni,'all') * uni;
uniDrops=filter2(uni,b,'valid'); %Performing uniform filter correlation
uniDropsEdge=filter2(sobx,uniDrops,'valid'); %performing edge dectection
%Displaying results
figure
imagesc(uniDropsEdge)
colormap('gray')
axis off image
title('Sobel x Edge Detection prepossessed with Uniform Filter')
exportgraphics(gcf,'UniSobelXDrops.png','Resolution',300)
%creating Gaussian kernal
Gauss=1/16 .* [1 2 1;2 4 2;1 2 1];
GaussDrops=filter2(Gauss,b,'valid');%performing gaussian 
GaussDropsEdge=filter2(sobx,GaussDrops,'valid'); %edge detection
%Displaying Results
figure
imagesc(GaussDropsEdge)
colormap('gray')
axis off image
title('Sobel x Edge Detection prepossessed with Gausian Filter')
exportgraphics(gcf,'GaussSobelXDrops.png','Resolution',300)
