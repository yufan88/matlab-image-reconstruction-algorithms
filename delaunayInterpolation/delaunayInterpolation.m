% Inpaint I_sample image
% output - inpainted image Im
% input - I_sample, n \times n masked image
% input - E, n\times n mask
% Yufan - 2016/4/2


function [ Im ] = delaunayInterpolation( I_sample, E )

    n = length(E);
    
    Im = zeros(n,n);
    
    for i = 1:n
        for j = 1:n
            
            if E(i,j) == 1
                Im(i,j) = I_sample(i,j);
            else
                Im(i,j) = -1;
            end
            
        end
    end
    
    x=[];
    y=[];
    z=[];

    for j = 1:n
        for i = 1:n
            if Im(i,j) ~= -1
                x(end+1) = j;
                y(end+1) = i;
                z(end+1) = Im(i,j);
            end
        end
    end

    tri = delaunay(x,y);
    
    
    [a b] =  size(tri);


    for k = 1 : a
        xmax = ceil(max(x(tri(k,:))));
        xmin = floor(min(x(tri(k,:))));
        ymax = ceil(max(y(tri(k,:))));
        ymin = floor(min(y(tri(k,:))));
        p1 = [x(tri(k,1)),y(tri(k,1))];
        p2 = [x(tri(k,2)),y(tri(k,2))];
        p3 = [x(tri(k,3)),y(tri(k,3))];
        for j = xmin : xmax
            for i = ymin : ymax
                if ifinsideTriangle(p1,p2,p3,[j,i]) && Im(i,j) == -1
                    c1 = z(tri(k,1));
                    c2 = z(tri(k,2));
                    c3 = z(tri(k,3));
                    Im(i,j) = colorPrint(p1,p2,p3,[j,i],c1,c2,c3);
                    continue;            
                end 
            end
        end    
    end



    for j = 1:n
        for i = 1:n
            if Im(i,j) == -1
                Im(i,j)=randi(256)-1;
            end
        end
    end
    
    
    

end

