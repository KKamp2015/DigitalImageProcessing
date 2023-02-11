%Housekeeping commands
clear all
close all

Drops=imread('Drops.jpeg'); %reading in image
Drops=im2gray(Drops); %converting to grayscale
FDrops=fft2(Drops);
imagesc(log10(abs(fftshift(FDrops))))
colormap('gray')
axis off image
title('Fourier Transform')
exportgraphics(gcf,'FFTDrops.png','Resolution',300)
x=-(length(Drops)-1)/2 :(length(Drops)-1)/2;

[X,Y]=meshgrid(x);

R=sqrt(X.^2 + Y.^2);

circlow=cast(R<length(Drops)/8,'double');
figure
imagesc(circlow)
colormap('gray')
axis off image
title('Low Pass Circle')
exportgraphics(gcf,'LowPassMask.png','Resolution',300)

FDropsLow=fftshift(FDrops).*circlow;

DropsLow=abs(ifft2(FDropsLow));
figure
imagesc(DropsLow)
colormap('gray')
axis off image
title('Drops Low Pass')
exportgraphics(gcf,'DropsLowPass.png','Resolution',300)

circhigh=cast(R<length(Drops)/4,'double');
figure
imagesc(circhigh)
colormap('gray')
axis off image
title('High Pass Circle')
exportgraphics(gcf,'HighPassMask.png','Resolution',300)
FDropsHigh=fftshift(FDrops).*circhigh;

DropsHigh=abs(ifft2(FDropsHigh));
figure
imagesc(DropsHigh)
colormap('gray')
axis off image
title('Drops High Pass')
exportgraphics(gcf,'DropsHighPass.png','Resolution',300)