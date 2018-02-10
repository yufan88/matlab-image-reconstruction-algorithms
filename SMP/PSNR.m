function [ c ] = PSNR(A,B)
   t=0;
   [a b] = size(A);
   for i = 1:a
       for j = 1:b
           t = t+(A(i,j)-B(i,j))^2;
       end
   end
   t = t/a/b;
   c = 20*log10(255)-10*log10(t);

end

