close all
clear all
%part 1 using imread
figure
a=imread('Drops.jpeg','jpeg');
a=a(:,:,1);
clims=[0,32];
imagesc(a,clims);
colormap('gray');
axis image off;
saveas(gcf,'Drops32.png')

clear
figure
b=imread('Drops.jpeg','jpeg');
b=b(:,:,1);
clims=[0,255];
imagesc(b,clims);
colormap('gray');
axis image off;
saveas(gcf,'Drops255.png')

%Task 2
clear all
figure
a=imread('Drops.jpeg','jpeg');
a=a(:,:,1);
imagesc(a);
colormap('lines');
axis image off;
saveas(gcf,'Dropslines.png')
clear all
figure
b=imread('Drops.jpeg','jpeg');
b=b(:,:,1);
imagesc(b);
colormap('turbo');
axis image off;
saveas(gcf,'Dropsturbo.png')

%Task3
c=imread('Drops.jpeg','jpeg');
c=c(:,:,1);
clims=[0,255];
Ns=[1,5,10];
MSE=[];
for j=1:length(Ns)
    N=Ns(j);
    for i=1:N
        images=zeros(size(c),'uint8');
        noise=uint8(floor(randn(256).*20+20));
        imageN=c+noise;
        images=images+imageN;
    end
    figure
    M=images/N;
    colormap('gray');
    imagesc(M);
    axis image off;
    title([num2str(N),' average'])
    saveas(gcf,['Drops',num2str(N),'.png'])
    MSE=[MSE,sum((M-c).^2,'all')];
end
figure
semilogy(Ns,sqrt(MSE),'o')
xlabel('Number in Average')
ylabel('$$\sqrt{MSE}$$','Interpreter','latex')
saveas(gcf,'NvsMSE.png')
%Task4
d=imread('Drops.jpeg','jpeg');
d=d(:,:,1);
figure
theta=35;
s=0.7;
strans=[s 0 0; 0 s 0; 0 0 1];
rtrans=[cosd(theta) -sind(theta) 0; sind(theta) cosd(theta) 0; 0 0 1];
trans=rtrans*strans;
tform = affine2d(trans);
out=imwarp(d,tform);
imagesc(out);
colormap('gray')
axis image
axis off
saveas(gcf,'DropsTransform.png')