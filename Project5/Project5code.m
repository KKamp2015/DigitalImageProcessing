%Housekeeping commands
clear all
close all
Drops=imread('City.jpeg'); %reading in image
    Drops=im2gray(Drops); %converting to grayscale
    figure
    imagesc(Drops)
    axis off image
    colormap('gray')
MSEs=zeros(4,5);
for l=1:4
    k=10*l;
    noise=uint8(floor(randn(length(Drops)).*k)); %making noise array
    nvar=var(cast(noise,'double'),0,'all');
    NDrops=Drops+noise;
    figure
    imagesc(NDrops)
    title({'Noisy Image','sigma:'+string(k)})
    axis off image
    colormap('gray')
    exportgraphics(gcf,'Noisy'+string(k)+'.png','Resolution',300)
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
    MSEs(l,1)=MSE;
    imagesc(AMean)
    title({'Arithmetic Mean','sigma:'+string(k), 'MSE:'+string(MSE)})
    axis off image
    colormap('gray')
    exportgraphics(gcf,'AMean'+string(k)+'.png','Resolution',300)
    figure
    image(Gmean)
    MSE=immse(cast(Drops,'double'),Gmean);
    MSEs(l,2)=MSE;
    title({'Geometric Mean','sigma:'+string(k), 'MSE:'+string(MSE)})
    axis off image
    colormap('gray')
    exportgraphics(gcf,'GMean'+string(k)+'.png','Resolution',300)
    figure
    MSE=immse(cast(Drops,'double'),Midpoint);
    MSEs(l,3)=MSE;
    image(Midpoint)
    title({'Midpoint Filter','sigma:'+string(k), 'MSE:'+string(MSE)})
    axis off image
    colormap('gray')
    exportgraphics(gcf,'MidPoint'+string(k)+'.png','Resolution',300)
    figure
    MSE=immse(cast(Drops,'double'),Adapt);
    MSEs(l,4)=MSE;
    imagesc(Adapt)
    title({'Adaptive Filter', 'sigma:'+string(k),'MSE:'+string(MSE)})
    axis off image
    colormap('gray')
    exportgraphics(gcf,'Adapt'+string(k)+'.png','Resolution',300)
    figure
    MSE=immse(cast(Drops,'double'),AdaptMed);
    MSEs(l,5)=MSE;
    imagesc(AdaptMed)
    title({'Adaptive Medial Filter','sigma:'+string(k), 'MSE:'+string(MSE)})
    axis off image
    colormap('gray')
    exportgraphics(gcf,'AdaptMed'+string(k)+'.png','Resolution',300)
end
figure
c={'Amean','Gman','Midpoint','Adapt','AdaptMed'};
scatter(10:10:40,MSEs,'filled')
legend(c)
xlabel('Sigma')
ylabel('MSE')
title('Sigma vs MSE')
exportgraphics(gcf,'SigmavsMSE.png','Resolution',300)

function A=AdaptFilter(X,eta)
    ml=mean(X,'all');
    L=var(cast(X,'double'),0,"all");
    g=X(ceil(length(X)/2),ceil(length(X)/2));
    A=g-((eta/L)*(g-ml));
end

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