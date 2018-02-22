function [ v ] = PixelMatrixToVector( m )

N = length(m);

for i = 1:N
    for j = 1:N
        v(N*(i-1)+j,1) = m(i,j);
    end
end

end

