%Housekeeping commands
clear all
close all

Cells=imread('Cells.tif');
Cells=im2gray(Cells);

minval=double(min(Cells,[],'all'));
maxval=double(max(Cells,[],'all'));

figure
hist=histogram(Cells,255);
Mg=mean(Cells,'all');
histnorm=hist.Values/sum(hist.Values,'all');
P1=zeros([1,255]);
M1=zeros([1,255]);
M2=zeros([1,255]);
for i = minval:maxval
    P1(i)=sum(histnorm(1:i),"all");
    t=Cells<=i;
    M1(i)=mean(Cells(t));
    M2(i)=mean(Cells(~t));

end
P2=ones(size(P1))-P1;
sigB2=(Mg.*P1-M1.*P1).^2 ./(P1.*P2);

[TreshVal,Tresh]=max(sigB2);

CellsTresh=uint8(Cells<Tresh-1);
figure
imagesc(CellsTresh)
axis off image
colormap('gray')
title("Otsu's Algorithm Output")
exportgraphics(gcf,'Otsu.png','Resolution',300)

