%Housekeeping commands
close all
clear all

figure
a=imread('Drops.jpeg','jpeg'); %reading in image
a=im2gray(a);
clims=[0,32]; %Setting number of levels
imagesc(a,clims); %displaing scaled image
colormap('gray'); %setting color map
axis image off; %turing off axes
%saving image this way to reduce white space with a DPI of 300
exportgraphics(gcf,'Drops32.png','Resolution',300)

clear all %clearing all to start fesh
figure
b=imread('Drops.jpeg','jpeg');
b=im2gray(b);
clims=[0,255]; %setting levels to 255
imagesc(b,clims);
colormap('gray');
axis image off;
exportgraphics(gcf,'Drops255.png','Resolution',300)

%Task 2
clear all %fresh start
figure
a=imread('Drops.jpeg','jpeg');
a=im2gray(a);
imagesc(a);
colormap('lines'); %using lines colormap
axis image off;
exportgraphics(gcf,'Dropslines.png','Resolution',300)
clear all
figure
b=imread('Drops.jpeg','jpeg');
b=b(:,:,1);
imagesc(b);
colormap('turbo'); %using turbo colormap
axis image off;
exportgraphics(gcf,'Dropsturbo.png','Resolution',300)

%Task3
clear all
c=imread('Drops.jpeg','jpeg');
c=im2gray(c);
clims=[0,255];
Ns=[1,5,10]; %setting number of images to average for each run
MSE=zeros(size(Ns)); %allocation
for j=1:length(Ns) %itterating over runs
    N=Ns(j);
    for i=1:N % itterating over number of images to be averaged
        images=zeros(size(c),'uint8'); %allocating memory
        noise=uint8(floor(randn(256).*20+20)); %making noise array
        imageN=c+noise; %adding noise to original image
        images=images+imageN; %adding all images together
    end
    figure
    M=images/N; % divinding by number of images coadded
    colormap('gray');
    imagesc(M);
    axis image off;
    title([num2str(N),' average']) %labeling the number of used 
    exportgraphics(gcf,['Drops',num2str(N),'.png'],'Resolution',300)
    MSE(j)=sum((M-c).^2,'all');%calculating MSE
end
figure
 %plotting sqrt(MSE) vs N as semilog 
semilogy(Ns,sqrt(MSE),'.','MarkerSize',25)
%labeling axes and title
xlabel('Number in Average')
ylabel('$$\sqrt{MSE}$$','Interpreter','latex')
title('N vs MSE')
exportgraphics(gcf,'NvsMSE.png','Resolution',300)
%Task4
d=imread('Drops.jpeg','jpeg');
d=im2gray(d);
figure
theta=35; %setting roation degree
s=0.7; %setting scale factor
strans=[s 0 0; 0 s 0; 0 0 1]; %creating scale transfrom matrix
%creating roating transfrom matrix
rtrans=[cosd(theta) -sind(theta) 0; sind(theta) cosd(theta) 0; 0 0 1];
trans=rtrans*strans; %creating total transfrom maxtix
tform = affine2d(trans); %creating the transfrom
out=imwarp(d,tform); % applying the transfrom
imagesc(out);
colormap('gray')
axis image
axis off
exportgraphics(gcf,'DropsTransform.png','Resolution',300)