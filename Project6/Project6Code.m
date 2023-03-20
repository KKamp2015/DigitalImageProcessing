%Housekeeping commands
clear all
close all

lines=imread('Lines.png'); %Reading in input
lines=cast(im2gray(lines),'double'); %converting to graycale
noise=cast(floor(randn(size(lines)).*200),'double'); %creating noise
Nlines=lines+noise; %adding noise
%displying noisy image
figure
imagesc(Nlines)
colormap('gray')
axis off image
title('Input Lines Image with Noise')
exportgraphics(gcf,'NoisyLines.png','Resolution',300)

Rlines=radon(Nlines,1:179);%taking radon transform for all 180 degress
figure
imagesc(Rlines)
colormap('gray')
title('Radon of Lines')
exportgraphics(gcf,'RadonLines.png','Resolution',300)

Recon=max(Rlines,[],'all')*0.75<Rlines;% taking 75% of max radon
BRlines=Rlines.*Recon; %masking radon transfrom
LinesRecon=iradon(BRlines,1:179);%taking inverse radon transfrom
%diplsaying reconstuction
figure
imagesc(LinesRecon)
colormap('gray')
axis off image
title('Lines recontruction with 75% max Radon')
exportgraphics(gcf,'ReconLines.png','Resolution',300)
%Part 2

city=imread("RoadwaySQ.jpg");%reading input
city=im2gray(city); %converting to grayscale
s=size(city);
%displying and saving input image
figure
imagesc(city)
colormap('gray')
axis off image
title('Input City Image')
exportgraphics(gcf,'Input.png','Resolution',300)

Rcity=radon(city,1:179);%radon transfrom
%displaiying radon transfrom
figure
imagesc(Rcity)
colormap('gray')
title('Radon of City')
exportgraphics(gcf,'RadonRoad.png','Resolution',300)

figure
hold on
imagesc(city)%displaying roadway
set(gca,'YDir','reverse') %needed to do this for overplotting
colormap('gray')
axis off image
CityMax=max(Rcity,[],'all')==Rcity;%finding bightest point in radon trans
BRcity=CityMax;
CityRecon=iradon(BRcity,1:179);% inverser radon transfrom of bright point
%overplotting dominate line
[X,Y,~]=find(CityRecon>0);
plot(Y,X,LineWidth=2,color='red')
title('Overplot of Prominent line')
exportgraphics(gcf,'LineOverplot.png','Resolution',300)