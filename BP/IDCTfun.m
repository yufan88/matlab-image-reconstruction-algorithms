function [ output ] = IDCTfun( z,E )

    output = idct2(z);
    output = output(find(E>0.5));

end

