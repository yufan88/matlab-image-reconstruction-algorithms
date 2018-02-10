clc;
close all;



I = imread([pwd '/lena256.jpg']);

if length(size(I)) > 2
I = rgb2gray(I);
end
I = double(I);

[n m] = size(I);

pixelifsampled = zeros(n,m);

for i = 1:n
    for j = 1:m
        if rand<0.25
            pixelifsampled(i,j) = 1;
        end
    end
end

% ================ SMP ===================


% close all;
% 
% 
% Ir = SMP( I.*pixelifsampled,pixelifsampled,round(0.02*n*m));
% 
% 
% close all;
% 
% 
% subplot(1,2,1)
% imshow(I.*pixelifsampled,[0 255]);
% title('sample');
% subplot(1,2,2)
% imshow(Ir,[0 255]);
% title('SMP reconstruction');
% 
% 
% 
% close all;


% ================ SMP ===================

close all;

Ir = TVinpainting( I.*pixelifsampled,pixelifsampled,1400);

close all;

subplot(1,2,1)
imshow(I.*pixelifsampled,[0 255]);
title('sample');
subplot(1,2,2)
imshow(Ir,[0 255]);
title('TV reconstruction');









