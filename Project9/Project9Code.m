%Housekeeping commands
clear all
close all

Dots=imread('Dots.gif');
Dots=im2gray(Dots);
Dots=Dots./max(Dots);
Dots=cast(Dots==0,'uint8');

DotsB=padarray(Dots,[1 1], 1); 

CC=bwconncomp(DotsB);
numPixels = cellfun(@numel,CC.PixelIdxList);
[biggest,idx] = max(numPixels);
Boarder=zeros(size(DotsB));
Boarder(CC.PixelIdxList{1,idx})=1;

figure
imagesc(Boarder)
colormap('gray')
axis off image
title('Dots Touching Boarder')
exportgraphics(gcf,'Boarder.png','Resolution',300)

M=mode(numPixels);

idxs=find(numPixels==M);

single=zeros(size(DotsB));
for i=1:length(idxs)
    single(CC.PixelIdxList{1,idxs(i)})=1;
end

figure
imagesc(single)
colormap('gray')
axis off image
title('Single Dots')
exportgraphics(gcf,'Single.png','Resolution',300)

connected=DotsB-uint8(Boarder+single);

figure
imagesc(connected)
colormap('gray')
axis off image
title('Connected Dots')
exportgraphics(gcf,'Connected.png','Resolution',300)