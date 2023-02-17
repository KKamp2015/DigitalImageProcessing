%Housekeeping commands
clear all
close all

Drops=imread('Drops.jpeg'); %reading in image
Drops=im2gray(Drops); %converting to grayscale
FDrops=fft2(Drops); %proforming the Fourier transfrom
%Displaying the Freq response and shiting it 
imagesc(log10(abs(fftshift(FDrops))))
colormap('gray') %use gray colormap
axis off image %axis opperations
title('Fourier Transform') %Title
exportgraphics(gcf,'FFTDrops.png','Resolution',300)%saving image

%Creating an array with 0 in the center that is the width of the image
x=-(length(Drops)-1)/2 :(length(Drops)-1)/2;

[X,Y]=meshgrid(x);%meshgrid to make 2 2d arrays to multiple

R=sqrt(X.^2 + Y.^2); %getting distance from the center point
%Finding there the disnace is less then 1/8 radius (1/4 diameter)
circlow=cast(R<length(Drops)/8,'double');

%Displaying mask
figure
imagesc(circlow)
colormap('gray')
axis off image
title('Low Pass Circle')
exportgraphics(gcf,'LowPassMask.png','Resolution',300)
%applying filter to FFT
FDropsLow=fftshift(FDrops).*circlow;

DropsLow=abs(ifft2(FDropsLow));% inverse Fourier transfrom
%displaying inverse Fourier transfrom
figure
imagesc(DropsLow)
colormap('gray')
axis off image
title('Drops Low Pass')
exportgraphics(gcf,'DropsLowPass.png','Resolution',300)

%creating unifrom filter 
NormFilter=ones(3); %memory allocation
NormFilter=1/sum(NormFilter,'all').*NormFilter;%making normalization kernal

%padding array on all sides to fit image
PadNorm=padarray(NormFilter,[(length(Drops)-1)/2 (length(Drops)-1)/2],0);
FPadNorm=fft2(PadNorm);%Fourier transfrom
%displaing Fourier transfrom
figure
imagesc(abs(fftshift(FPadNorm)))
colormap('gray')
title('Fourier Transform of Uniform Filter')
colormap('gray')
axis off image
exportgraphics(gcf,'FUniform.png','Resolution',300)

%Finding values greater than 1/2 the width of the image (1/4 radius)
circhigh=cast(R>length(Drops)/4,'double');
%displaying Figure
figure
imagesc(circhigh)
colormap('gray')
%some werid stuff i had to do cause it was cropping on export
box on
set(gca,'xtick',[])
set(gca,'xticklabel',[])
set(gca,'ytick',[])
set(gca,'yticklabel',[])
axis image
title('High Pass Circle')
exportgraphics(gcf,'HighPassMask.png','Resolution',300)
%applying mask
FDropsHigh=fftshift(FDrops).*circhigh;

DropsHigh=abs(ifft2(FDropsHigh)); %inverse Fourier transfrom
figure
imagesc(DropsHigh)
colormap('gray')
axis off image
box on
title('Drops High Pass')
exportgraphics(gcf,'DropsHighPass.png','Resolution',300)

sobx=[1 0 -1;2 0 -2;1 0 -1]; %Creating Sobel opperator
PadSobx=padarray(sobx,[(length(Drops)-1)/2 (length(Drops)-1)/2],0);
FSobx=fft2(PadSobx); %Fourier transfrom
soby=sobx'; %Creating Sobel opperator
PadSoby=padarray(soby,[(length(Drops)-1)/2 (length(Drops)-1)/2],0);
FSoby=fft2(PadSoby);Fourier transfrom
figure
imagesc(abs(fftshift(FSoby))+abs(fftshift(FSobx)));% adding and dispalying
title('Fourier Transform of Sobel Edge Detectors')
colormap('gray')
axis off image
exportgraphics(gcf,'FSobel.png','Resolution',300)

