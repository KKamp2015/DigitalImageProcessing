%clear all
%close all

Cells=imread('Cells.tif');
Cells=im2gray(Cells);
figure
hist=histogram(Cells,255);

Val=otsu(hist.Values);

CellsTresh1=uint8(Cells<Val);
figure
imagesc(CellsTresh1)
axis off image
colormap('gray')

function level = otsu(histogramCounts)
total = sum(histogramCounts); % total number of pixels in the image 
%% OTSU automatic thresholding
top = 255;
sumB = 0;
wB = 0;
maximum = 0.0;
sum1 = dot(0:top-1, histogramCounts);
for ii = 1:top
    wF = total - wB;
    if wB > 0 && wF > 0
        mF = (sum1 - sumB) / wF;
        val = wB * wF * ((sumB / wB) - mF) * ((sumB / wB) - mF);
        if ( val >= maximum )
            level = ii;
            maximum = val;
        end
    end
    wB = wB + histogramCounts(ii);
    sumB = sumB + (ii-1) * histogramCounts(ii);
end
end