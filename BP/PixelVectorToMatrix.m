function [ imageop ] = PixelVectorToMatrix( v, sizeofimage )

% N = length(v);
% 
% for i = 1:sqrt(N)
%     for j = 1:sqrt(N)
%         m(i,j) = v((i-1)*sqrt(N)+j);
%     end
% end

n = sizeofimage(1);
m = sizeofimage(2);
imageop = [];

for i = 1:n
    for j = 1:m
        imageop(i,j) = v((i-1)*m+j);
    end
end
    




end

