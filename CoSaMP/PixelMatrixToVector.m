function [ v ] = PixelMatrixToVector( x )

% N = length(m);
% 
% for i = 1:N
%     for j = 1:N
%         v(N*(i-1)+j,1) = m(i,j);
%     end
% end


[n m] = size(x);

for i = 1:n
    for j = 1:m
        v(m*(i-1)+j,1) = x(i,j);       
    end
end



end

