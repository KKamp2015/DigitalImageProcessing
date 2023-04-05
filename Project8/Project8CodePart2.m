%Housekeeping commands
clear all
close all

Bayes('beyl',20)
Bayes('beyl',30)
Bayes('beyl',40)

function Bayes(wav,s)
    disp(s)
    blankreigion=[0.0013 0.1523;0.6445 1]; %array for ratio of blank region
    
    Bridges=imread('Bridges.jpeg'); %Reading in input
    Bridges=cast(im2gray(Bridges),'double'); %converting to graycale
    noise=cast(floor(randn(size(Bridges)).*s),'double'); %creating noise
    NoisyBridge=Bridges+noise; %adding noise
    
    figure
    imagesc(NoisyBridge)
    colormap("gray")
    title({'Noisy Image','Sigma:'+string(s)})
    axis off image
    exportgraphics(gcf,'NoiseS'+string(s)+'.png','Resolution',300)
    
    [C,L]=wavedec2(NoisyBridge,2,wav);
    
    [H1,V1,D1]=detcoef2('all',C,L,1);
    A=appcoef2(C,L,wav,1);
    
    sz=size(H1);
    loc=round(blankreigion.*sz');
    sh=std2(H1(loc(1,1):loc(1,2),loc(2,1):loc(2,2)));
    sv=std2(V1(loc(1,1):loc(1,2),loc(2,1):loc(2,2)));
    sd=std2(D1(loc(1,1):loc(1,2),loc(2,1):loc(2,2)));
    disp([sh^2/s,sv^2/s,sd^2/s])
    H1t=Thresh(H1,sh^2 /s);
    V1t=Thresh(V1,sv^2 /s);
    D1t=Thresh(D1,sd^2 /s);
    
    
    BridgeOut=idwt2(A,H1t,V1t,D1t,wav);
    
    figure
    imagesc(BridgeOut)
    colormap('gray')
    axis image off
    title({'Denoised','Sigma:'+string(s)})
    exportgraphics(gcf,'DenoisedS'+string(s)+'.png','Resolution',300)
   
    function T=Thresh(A,t)
       sgn=sign(A);
       B=abs(A)-t;
       [x,y,~]=find(B<0);
       B(x,y)=0;
       T=B.*sgn;
    end
end

