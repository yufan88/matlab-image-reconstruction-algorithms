% check if p is inside p1,p2,p3 triangle
% output - t (boolean) Ture if inside, False otherwise
% input - p1,p2,p3 triangle,
% input - p target point
% Yufan - 2016/4/2


function [ t ] = ifinsideTriangle( p1,p2,p3,p )

    s_value = @(k1,k2,k3) (k1(1)-k3(1))*(k2(2)-k3(2)) - (k1(2)-k3(2))*(k2(1)-k3(1));

    s = abs(s_value(p1,p2,p3));
    
    s1 = abs(s_value(p,p2,p3));
    
    s2 = abs(s_value(p1,p,p3));
    
    s3 = abs(s_value(p1,p2,p));
    
    if s == s1+s2+s3
        t = true;
    else
        t = false;
    end





end

