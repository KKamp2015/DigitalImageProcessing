%Housekeeping commands
clear all
close all

Dots=imread('Dots.gif'); %reading in image
Dots=im2gray(Dots); %convering to grayscale
%making image binary
Dots=Dots./max(Dots); 
Dots=cast(Dots==0,'uint8');

DotsB=padarray(Dots,[1 1], 1); %padding array to have white boarder

CC=bwconncomp(DotsB); %proforming connected component algorithm
%finding size ofg each connected component
numPixels = cellfun(@numel,CC.PixelIdxList); 
%finding the size and index of the largest connected component
[biggest,idx] = max(numPixels);
Boarder=zeros(size(DotsB)); %alloacting memory for new image
Boarder(CC.PixelIdxList{1,idx})=1; %"printing" boarder dots on new image


%displaying and saving boarder image
figure
imagesc(Boarder)
colormap('gray')
axis off image
title('Dots Touching Boarder')
exportgraphics(gcf,'Boarder.png','Resolution',300)

%finding most common size of connected compoent
M=mode(numPixels);

%finding which compentents are that size
idxs=find(numPixels==M);

single=zeros(size(DotsB)); %allocating memory for image picture
for i=1:length(idxs) %itterating though single dots and "printing them
    single(CC.PixelIdxList{1,idxs(i)})=1;
end

%displaying and saving single dots image
figure
imagesc(single)
colormap('gray')
axis off image
title('Single Dots')
exportgraphics(gcf,'Single.png','Resolution',300)

%subtracting two other groupds to ger connected dots
connected=DotsB-uint8(Boarder+single);

%Dispalying and saving connected dots
figure
imagesc(connected)
colormap('gray')
axis off image
title('Connected Dots')
exportgraphics(gcf,'Connected.png','Resolution',300)