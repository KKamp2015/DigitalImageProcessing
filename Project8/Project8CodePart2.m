%Housekeeping commands
clear all
close all

Bridges=imread('Bridges.jpeg'); %Reading in input
Bridges=cast(im2gray(Bridges),'double'); %converting to graycale
noise=cast(floor(randn(size(Bridges)).*30),'double'); %creating noise
NosiyBridge=Bridges+noise; %adding noise

figure
imagesc(NosiyBridge)
colormap("gray")
title('Noisy Image')
axis off image

[C,L]=wavedec2(NosiyBridge,1,'db4');

Ct=Thresh(C,20);
BridgeOut=waverec2(Ct,L,'db4');

% [H1,V1,D1]=detcoef2('all',C,L,1);
% A=appcoef2(C,L,'beyl',1);
% 
% H1t=Thresh(H1,10);
% V1t=Thresh(V1,10);
% D1t=Thresh(D1,10);
% At=Thresh(A,10);
% 
% BridgeOut=idwt2(A,H1,V1,D1,'db4');

figure
imagesc(BridgeOut)
colormap('gray')
axis image off
title('Denoised')




function T=Thresh(A,t)
    [x,y,~]=find(abs(A)<=t);
    A(x,y)=0;
    T=A;
end

%NoiseSample=Bridges(1:117,330:512);
