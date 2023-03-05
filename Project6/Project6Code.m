%Housekeeping commands
clear all
close all

lines=imread('Lines.png');
lines=cast(im2gray(lines),'double');
noise=cast(floor(randn(size(lines)).*200),'double');
Nlines=lines+noise;
figure
imagesc(Nlines)
colormap('gray')
axis off image
title('Input Lines Image with Noise')
%exportgraphics(gcf,'NoisyLines.png','Resolution',300)
Rlines=radon(Nlines,1:179);
figure
imagesc(Rlines)
colormap('gray')
title('Radon of City')

city=imread("City.jpeg");
city=im2gray(city);
Ncity=city;
figure
imagesc(Ncity)
colormap('gray')
axis off image
title('Input City Image')
%exportgraphics(gcf,'Input.png','Resolution',300)

Rcity=radon(Ncity,1:179);
figure
imagesc(Rcity)
colormap('gray')
title('Radon of City')