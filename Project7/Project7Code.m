%Housekeeping commands
clear all
close all

%reading in image
City=imread('City.jpeg');
City=cast(im2gray(City),'double');
[M,N]=size(City);
MSEs=[0,0,0,0];%allocating memory for MSE larter
figure
%displaying input image
imagesc(City)
colormap('gray')
axis off image
title('Input City Image')
exportgraphics(gcf,'Input.png','Resolution',300)
angles=1:0.1:179;%projection angles
RCity=radon(City,angles); %radon transform
%displaying Radon transfrom
figure
imagesc(RCity)
xt = xticks;
xtnew=xt./10;
xticklabels(xtnew)
colormap('gray')
title('Radon Transfrom of City')
exportgraphics(gcf,'Radon.png','Resolution',300)

%first reconstuction
Recon=iradon(RCity,angles,"pchip","Ram-Lak");
Recon=Recon(2:M+1,2:N+1);%trimming edges so its same shape
MSE=immse(City,Recon);
MSEs(1)=MSE; %saving MSE
%Displaying reconstucted image
figure
imagesc(Recon)
colormap('gray')
axis off image
title({'pchip & Ram-Lak','MSE:'+string(MSE)})
exportgraphics(gcf,'pchipRL.png','Resolution',300)

%Second recontruction
Recon=iradon(RCity,angles,"nearest","Shepp-Logan");
Recon=Recon(2:M+1,2:N+1);%trimming edges so its same shape
MSE=immse(City,Recon);
MSEs(2)=MSE;
figure
imagesc(Recon)
colormap('gray')
axis off image
title({'nearest & Shepp-Logan','MSE:'+string(MSE)})
exportgraphics(gcf,'NearSL.png','Resolution',300)

%third reconstucition
Recon=iradon(RCity,angles,"linear","Hann");
Recon=Recon(2:M+1,2:N+1);%trimming edges so its same shape
MSE=immse(City,Recon);
MSEs(3)=MSE;
figure
imagesc(Recon)
colormap('gray')
axis off image
title({'Linear & Hann','MSE:'+string(MSE)})
exportgraphics(gcf,'LinearHann.png','Resolution',300)

%Fourth Reconstuction
Recon=iradon(RCity,angles,"v5cubic","Cosine");
Recon=Recon(2:M+1,2:N+1);%trimming edges so its same shape
MSE=immse(City,Recon);
MSEs(4)=MSE;
figure
imagesc(Recon)
colormap('gray')
axis off image
title({'v5cubic & Cosine','MSE:'+string(MSE)})
exportgraphics(gcf,'v5CCosine.png','Resolution',300)

%saving MSEs
fout=fopen('MSEs.txt','w');
fprintf(fout,'%f\n',MSEs);
