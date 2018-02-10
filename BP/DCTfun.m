function [ output ] = DCTfun( z,E )

    output = dct2(addzeros(z,E));

end
