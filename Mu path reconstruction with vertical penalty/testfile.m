clear;
clc;
close all;


I = imread([pwd '/lena_256.jpg']);

if length(size(I)) > 2
I = rgb2gray(I);
end
I = double(I);


[n m] = size(I);


E = muPathMaskGen(15,n,m,0.15);



[Ir] = BregmanSplitwithVerticalPenalty(I,E,0.03,0.0001,0.03,1000,40)













