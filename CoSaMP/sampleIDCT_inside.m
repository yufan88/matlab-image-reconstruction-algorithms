function y = sampleIDCT_inside(z,currentSet,E,mode)
   N = length(E);
   t = zeros(N,1);
   
   switch lower(mode)
    case 'notransp'
       t(currentSet) = z;
       y = idct(t);
       y = y(find(E>0.5));
        
    case 'transp'
        t(find(E>0.5))=z;
        y = dct(t);    
        y = y(currentSet);
        
        
   end 
   
   
   
end