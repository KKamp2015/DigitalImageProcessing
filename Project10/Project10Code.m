%Housekeeping commands
clear all
close all

Cells=imread('Cells.tif');
Cells=im2gray(Cells);

minval=min(Cells);
Maxval=max(Cells);
