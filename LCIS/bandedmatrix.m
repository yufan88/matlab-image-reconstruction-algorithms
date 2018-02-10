function [ A ] = bandedmatrix( n )


    A = zeros(n,n);
    
    for i = 2:n-1
        A(i,i)=-2;
        A(i,i-1)=1;
        A(i,i+1)=1;
    end
    
    A(1,1) = -1;
    A(1,2) = 1;
    
    A(n,n) = -1;
    A(n,n-1) = 1;

end

