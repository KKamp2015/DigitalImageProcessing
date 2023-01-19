close
clear
a=imread('output-onlinejpgtools.jpg','jpeg');
a=a(:,:,1);
imagesc(a);
colormap('gray');
axis image off

figure
%n=randn(size(a))
%imsec(n)