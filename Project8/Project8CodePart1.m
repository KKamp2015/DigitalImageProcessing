%Housekeeping commands
clear all
close all

Signal=ones(1,512);

[C,L]=wavedec(Signal,1,'beyl');
C=zeros(size(C));
C(300)=1;
X=waverec(C,L,'beyl');
figure
stem(X,'MarkerSize',0.1)
xlim([0,512])
title('Beylkin Wavelet N=1')
exportgraphics(gcf,'BeylkinN1.png','Resolution',300)

[C,L]=wavedec(Signal,1,'vaid');
C=zeros(size(C));
C(300)=1;
X=waverec(C,L,'vaid');
figure
stem(X,'MarkerSize',0.1)
xlim([0,512])
title('Vaidyanathan Wavelet N=1')
exportgraphics(gcf,'VaidyanathanN1.png','Resolution',300)

[C,L]=wavedec(Signal,1,'db4');
C=zeros(size(C));
C(300)=1;
X=waverec(C,L,'db4');
figure
stem(X,'MarkerSize',0.1)
xlim([0,512])
title('Daubechies4 Wavelet N=1')
exportgraphics(gcf,'Daubechies4N1.png','Resolution',300)

[C,L]=wavedec(Signal,2,'beyl');
C=zeros(size(C));
C(245)=1;
X=waverec(C,L,'beyl');
figure
stem(X,'MarkerSize',0.1)
xlim([0,512])
title('Beylkin Wavelet N=2')
exportgraphics(gcf,'BeylkinN2.png','Resolution',300)

[C,L]=wavedec(Signal,2,'vaid');
C=zeros(size(C));
C(245)=1;
X=waverec(C,L,'vaid');
figure
stem(X,'MarkerSize',0.1)
xlim([0,512])
title('Vaidyanathan Wavelet N=2')
exportgraphics(gcf,'VaidyanathanN2.png','Resolution',300)

[C,L]=wavedec(Signal,2,'db4');
C=zeros(size(C));
C(245)=1;
X=waverec(C,L,'db4');
figure
stem(X,'MarkerSize',0.1)
xlim([0,512])
title('Daubechies4 Wavelet N=2')
exportgraphics(gcf,'Daubechies4N2.png','Resolution',300)

[C,L]=wavedec(Signal,3,'beyl');
C=zeros(size(C));
C(120)=1;
X=waverec(C,L,'beyl');
figure
stem(X,'MarkerSize',0.1)
xlim([0,512])
title('Beylkin Wavelet')
exportgraphics(gcf,'BeylkinN3.png','Resolution',300)

[C,L]=wavedec(Signal,3,'vaid');
C=zeros(size(C));
C(120)=1;
X=waverec(C,L,'vaid');
figure
stem(X,'MarkerSize',0.1)
xlim([0,512])
title('Vaidyanathan Wavelet N=3')
exportgraphics(gcf,'VaidyanathanN3.png','Resolution',300)

[C,L]=wavedec(Signal,3,'db4');
C=zeros(size(C));
C(120)=1;
X=waverec(C,L,'db4');
figure
stem(X,'MarkerSize',0.1)
xlim([0,512])
title('Daubechies4 Wavelet N=3')
exportgraphics(gcf,'Daubechies4N3.png','Resolution',300)



