% calculate target pixel value

function [ color ] = colorPrint(p1,p2,p3,p,c1,c2,c3)
     
     aera_value = @(k1,k2,k3) abs(0.5*det([k1(1) k2(1) k3(1); k1(2) k2(2) k3(2); 1 1 1]));


     color = (c1*aera_value(p,p2,p3)+c2*aera_value(p,p1,p3)+c3*aera_value(p,p1,p2))/aera_value(p1,p2,p3);


end

