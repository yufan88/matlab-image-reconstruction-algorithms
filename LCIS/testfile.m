clc;
close all;
clear;



I = imread([pwd '/lena256.jpg']);

if length(size(I)) > 2
I = rgb2gray(I);
end
I = double(I);

I = I([56:200],:);

[n m] = size(I);

pixelifsampled = zeros(n,m);

for i = 1:n
    for j = 1:m
        if rand<0.3
            pixelifsampled(i,j) = 1;
        end
    end
end

% ================ LCIS ===================


close all;

Ir = LCIS_inpainting( I.*pixelifsampled, pixelifsampled, 100000, 0.5);

close all;

figure(1)
ax1 = subplot(1,2,1)
imshow(I.*pixelifsampled,[0 255]);
title('sample');
ax2 = subplot(1,2,2)
imshow(Ir,[0 255]);
title('LCIS reconstruction');
linkaxes([ax1 ax2], 'xy'); 
PSNR(I, Ir)







