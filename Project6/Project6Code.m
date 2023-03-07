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
title('Radon of Lines')

Recon=max(Rlines,[],'all')*0.75<Rlines;
BRlines=Rlines.*Recon;
LinesRecon=iradon(BRlines,1:179);
figure
imagesc(LinesRecon)
colormap('gray')
axis off image
title('Lines recontruction with 75% max Radon')
%exportgraphics(gcf,'ReconLines.png','Resolution',300)

city=imread("roadway.jpg");
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
%exportgraphics(gcf,'ReconLines.png','Resolution',300)
figure
hold on
imagesc(Ncity)
colormap('gray')
axis off image

CityMax=max(Rcity,[],'all')==Rcity;
BRcity=CityMax;
CityRecon=iradon(BRcity,1:179);
[X,Y,~]=find(CityRecon>0);
plot(X,Y)
axis off image
title('City recontruction with 75% max Radon')