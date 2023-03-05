%Housekeeping commands
clear all
close all
Drops=imread('City.jpeg'); %reading in image
Drops=im2gray(Drops); %converting to grayscale
figure %displaying input image
imagesc(Drops) 
axis off image
colormap('gray')
title('Input Image')
exportgraphics(gcf,'Input.png','Resolution',300)
MSEs=zeros(4,5); %allocating memory for MSEs
for l=1:4
    k=10*l; %setting standard dev for noise
    noise=uint8(floor(randn(length(Drops)).*k)); %making noise array
    nvar=var(cast(noise,'double'),0,'all'); %reclacluating var for noise
    NDrops=Drops+noise; %adding noise
    figure %displaying and saving noisy image
    imagesc(NDrops)
    title({'Noisy Image','sigma:'+string(k)})
    axis off image
    colormap('gray')
    exportgraphics(gcf,'Noisy'+string(k)+'.png','Resolution',300)
    [M,N]=size(Drops);
    NewImage=zeros([M,N]); %creating blank array for new images
    %allocating for new outputs
    AMean=NewImage;
    Gmean=NewImage;
    Midpoint=NewImage;
    Adapt=NewImage;
    AdaptMed=NewImage;
    for j=2:M-2 %sliding for y axis
        for i=2:N-2 %sliding for x axis
            %applying filtes
            AMean(i,j)=mean(NDrops(i-1:i+1,j-1:j+1),'all');
            Gmean(i,j)=geomean(cast(NDrops(i-1:i+1,j-1:j+1),'double'),'all');
            Midpoint(i,j)=median(NDrops(i-1:i+1,j-1:j+1),'all');
            Adapt(i,j)=AdaptFilter(NDrops(i-1:i+1,j-1:j+1),nvar);
            %applying Adaptive Meanfilter with changing window size
            Zout=-99;
            w=0;
            while Zout==-99 %fail value
                try
                Zout=AdaptMedFilter(NDrops(i-(1+w):i+(1+w),j-(1+w):j+(1+w)));
                w=w+1; %incrsing window size
                catch
                    %forcing max window size for edges
                    Zout=AdaptMedFilter(NDrops(i-(1+w):i+(1+w),j-(1+w):j+(1+w)),f=true);
                end
            end
            AdaptMed(i,j)=Zout;
        end
    end
    %displaing each new image
    figure
    MSE=immse(cast(Drops,'double'),AMean);% Calculating MSE
    MSEs(l,1)=MSE; %adding to MSE array
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
%plotting MSE vs Sigma
figure
c={'Amean','Gman','Midpoint','Adapt','AdaptMed'};
scatter(10:10:40,MSEs,'filled')
legend(c)
xlabel('Sigma')
ylabel('MSE')
title('Sigma vs MSE')
exportgraphics(gcf,'SigmavsMSE.png','Resolution',300)

function A=AdaptFilter(X,eta) %adaptive filter defination
    ml=mean(X,'all');
    L=var(cast(X,'double'),0,"all");
    g=X(ceil(length(X)/2),ceil(length(X)/2));
    A=g-((eta/L)*(g-ml));
end

function A=AdaptMedFilter(X,f) %Adaptive med filter def
    if nargin < 2 %setting default values
        f = true;
    end
    %calcualting needed values
    zmin=min(X,[],'all');
    zmax=max(X,[],'all');
    zmed=median(X,'all');
    zxy=X(ceil(length(X)/2),ceil(length(X)/2)); %central value
    if zmed==zmin || zmed==zmax
        if length(X)==7
            A=zmed;
        elseif f==true %forceing max window size
            A=zmed;
        else
            A=-99;% for increasing window size
        end
    else
        if zmed==zmin || zmed==zmax
            A=zmed;
        else
            A=zxy;
        end
    end

end