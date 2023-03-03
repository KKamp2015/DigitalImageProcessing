%Housekeeping commands
clear all
close all
Drops=imread('City.jpeg'); %reading in image
Drops=im2gray(Drops); %converting to grayscale
figure
imagesc(Drops)
axis off image
colormap('gray')
noise=uint8(floor(randn(length(Drops)).*10)); %making noise array
nvar=var(cast(noise,'double'),0,'all');
NDrops=Drops+noise;
[M,N]=size(Drops);
NewImage=zeros([M,N]);
AMean=NewImage;
Gmean=NewImage;
Midpoint=NewImage;
Adapt=NewImage;
AdaptMed=NewImage;
for j=2:M-2
    for i=2:N-2
        AMean(i,j)=mean(NDrops(i-1:i+1,j-1:j+1),'all');
        Gmean(i,j)=geomean(cast(NDrops(i-1:i+1,j-1:j+1),'double'),'all');
        Midpoint(i,j)=median(NDrops(i-1:i+1,j-1:j+1),'all');
        Adapt(i,j)=AdaptFilter(NDrops(i-1:i+1,j-1:j+1),nvar);
        Zout=AdaptMedFilter(NDrops(i-1:i+1,j-1:j+1));
        AdaptMed(i,j)=Zout;
    end
end
figure
MSE=immse(cast(Drops,'double'),AMean);
imagesc(AMean)
title({'Arithmetic Mean', 'MSE:'+string(MSE)})
axis off image
colormap('gray')
exportgraphics(gcf,'AMean.png','Resolution',300)
figure
image(Gmean)
MSE=immse(cast(Drops,'double'),Gmean);
title({'Geometric Mean', 'MSE:'+string(MSE)})
axis off image
colormap('gray')
exportgraphics(gcf,'GMean.png','Resolution',300)
figure
MSE=immse(cast(Drops,'double'),Midpoint);
image(Midpoint)
title({'Midpoint Filter', 'MSE:'+string(MSE)})
axis off image
colormap('gray')
exportgraphics(gcf,'MidPoint.png','Resolution',300)
figure
MSE=immse(cast(Drops,'double'),Adapt);
imagesc(Adapt)
title({'Adaptive Filter', 'MSE:'+string(MSE)})
axis off image
colormap('gray')
exportgraphics(gcf,'Adapt.png','Resolution',300)
figure
MSE=immse(cast(Drops,'double'),AdaptMed);
imagesc(AdaptMed)
title({'Adaptive Medial Filter', 'MSE:'+string(MSE)})
axis off image
colormap('gray')
exportgraphics(gcf,'AdaptMed.png','Resolution',300)

function A=AdaptMedFilter(X)
    zmin=min(X,[],'all');
    zmax=max(X,[],'all');
    zmed=median(X,'all');
    zxy=X(ceil(length(X)/2),ceil(length(X)/2));
    if zmed==zmin || zmed==zmax
        if length(X)==3
            A=zmed;
        else
            A=-99;
        end
    else
        if zmed==zmin || zmed==zmax
            A=zmed;
        else
            A=zxy;
        end
    end

end