clc;
close all;

addpath(genpath([pwd '/l1magic']));

% ============== load image =============

I = imread([pwd '/lena256.jpg']);

if length(size(I)) > 2
I = rgb2gray(I);
end
I = double(I);

[n m] = size(I);

% ==============sample image ===============

pixelifsampled = zeros(n,m);

for i = 1:n
    for j = 1:m
        if rand<0.25
            pixelifsampled(i,j) = 1;
        end
    end
end

% ================ BP ===================

I_vector = PixelMatrixToVector(I);
pixelifsampled = PixelMatrixToVector(pixelifsampled);
I_vector = I_vector(find(pixelifsampled>0.5));

A = @(x) IDCTfun(x,pixelifsampled);
At = @(x) DCTfun(x,pixelifsampled);


close all;


Ir = idct(l1qc_logbarrier(At(I_vector), A, At, I_vector, 0.1));


close all;


subplot(1,2,1)
imshow(I.*PixelVectorToMatrix(pixelifsampled,[n m]),[0 255]);
title('sample');
subplot(1,2,2)
imshow(PixelVectorToMatrix(Ir,[n m]),[0 255]);
title('BP reconstruction');




