%Housekeeping commands
clear all
close all
wav='beyl';
Bridges=imread('Bridges.jpeg'); %Reading in input
Bridges=cast(im2gray(Bridges),'double'); %converting to graycale
noise=cast(floor(randn(size(Bridges)).*20),'double'); %creating noise
NoisyBridge=Bridges+noise; %adding noise

figure
imagesc(NoisyBridge)
colormap("gray")
title('Noisy Image')
axis off image

[C,L]=wavedec2(NoisyBridge,1,wav);

Ct=Thresh(C,30);

BridgeOut=waverec2(Ct,L,wav);

% [s]=detcoef2('all',C,L,1);
% A=appcoef2(C,L,wav,1);
% 
% H1t=Thresh(H1,300);
% V1t=Thresh(V1,300);
% D1t=Thresh(D1,300);
% At=Thresh(A,300);
% 
% BridgeOut=idwt2(A,H1,V1,D1,wav);

figure
imagesc(BridgeOut)
colormap('gray')
axis image off
title('Denoised')




function T=Thresh(A,t)
   s=sign(A);
   B=abs(A)-t;
   [x,y,~]=find(B<0);
   B(x,y)=0;
   T=B.*s;
end

%NoiseSample=Bridges(1:117,330:512);
