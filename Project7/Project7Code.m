%Housekeeping commands
clear all
close all


City=imread('City.jpeg');
City=cast(im2gray(City),'double');
[M,N]=size(City);
MSEs=[0,0,0,0];
figure
imagesc(City)
colormap('gray')
axis off image
title('Input City Image')
%exportgraphics(gcf,'Input.png','Resolution',300)
angles=1:0.1:179;
RCity=radon(City,angles);
figure
imagesc(RCity)
xt = xticks;
xtnew=xt./10;
xticklabels(xtnew)
colormap('gray')
title('Radon Transfrom of City')
%exportgraphics(gcf,'Radon.png','Resolution',300)

Recon=iradon(RCity,angles,"pchip","Ram-Lak");
Recon=Recon(2:M+1,2:N+1);%trimming edges so its same shape
MSE=immse(City,Recon);
MSEs(1)=MSE;
figure
imagesc(Recon)
colormap('gray')
axis off image
title({'pchip & Ram-Lak','MSE:'+string(MSE)})
%exportgraphics(gcf,'pchipRL.png','Resolution',300)

Recon=iradon(RCity,angles,"nearest","Shepp-Logan");
Recon=Recon(2:M+1,2:N+1);%trimming edges so its same shape
MSE=immse(City,Recon);
MSEs(2)=MSE;
figure
imagesc(Recon)
colormap('gray')
axis off image
title({'nearest & Shepp-Logan','MSE:'+string(MSE)})
%exportgraphics(gcf,'NearSL.png','Resolution',300)


Recon=iradon(RCity,angles,"linear","Hann");
Recon=Recon(2:M+1,2:N+1);%trimming edges so its same shape
MSE=immse(City,Recon);
MSEs(3)=MSE;
figure
imagesc(Recon)
colormap('gray')
axis off image
title({'Linear & Hann','MSE:'+string(MSE)})
%exportgraphics(gcf,'LinearHann.png','Resolution',300)

Recon=iradon(RCity,angles,"v5cubic","Cosine");
Recon=Recon(2:M+1,2:N+1);%trimming edges so its same shape
MSE=immse(City,Recon);
MSEs(4)=MSE;
figure
imagesc(Recon)
colormap('gray')
axis off image
title({'v5cubic & Cosine','MSE:'+string(MSE)})
%exportgraphics(gcf,'v5CCosine.png','Resolution',300)

fout=fopen('MSEs.txt','w');
fprintf(fout,'%f\n',MSEs);
