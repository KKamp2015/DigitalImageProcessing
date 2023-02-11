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

NormFilter=ones(3); %memory allocation
NormFilter=1/sum(NormFilter,'all').*NormFilter;%making normalization kernal

PadNorm=padarray(NormFilter,[(length(Drops)-1)/2 (length(Drops)-1)/2],0);
FPadNorm=fft2(PadNorm);
figure
imagesc(abs(fftshift(FPadNorm)))
colormap('gray')
title('Fourier Transform of Uniform Filter')
colormap('gray')
exportgraphics(gcf,'FUniform.png','Resolution',300)


circhigh=cast(R>length(Drops)/4,'double');
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

sobx=[1 0 -1;2 0 -2;1 0 -1]; %Creating Sobel opperator
PadSobx=padarray(sobx,[(length(Drops)-1)/2 (length(Drops)-1)/2],0);
FSobx=fft2(PadSobx);
figure
imagesc(abs(fftshift(FSobx)));
title('Fourier Transform of Sobel X Filter')
colormap('gray')
exportgraphics(gcf,'FSobx.png','Resolution',300)

soby=sobx'; %Creating Sobel opperator
PadSoby=padarray(soby,[(length(Drops)-1)/2 (length(Drops)-1)/2],0);
FSoby=fft2(PadSoby);
figure
imagesc(abs(fftshift(FSoby)));
title('Fourier Transform of Sobel Y Filter')
colormap('gray')
exportgraphics(gcf,'FSoby.png','Resolution',300)

