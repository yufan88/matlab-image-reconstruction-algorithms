%-----------------------------------------------------------------------
%  TV inpainting described in ------------------------------------------
%  mathematical models for local non texture in paintings by YUFAN LUO ---
%  this program is designed for TV image inpainting reconstruction
%  this program is only used for black - white images


%  inputs
%  I_sample        - sampled image (the size should be n^2)
%  pixelifsampled  - knowledgement matrix (the size should be n^2, if pixel i,j is 
%                               known E(i,j) = 1, else E(i,j)=0)
%  maxiter         - max value of # iter (optional)


%  output
%  reconsturctionresult  -  reconstruction (with size n^2)


function [ reconsturctionresult ] = TVinpainting( I_sample, pixelifsampled, maxiter )

	
    if length(size(I_sample)) > 2
        I_sample = rgb2gray(I_sample);
    end
    
    if nargin < 3
        maxiter = 3000;
    end
    
    n = length(pixelifsampled);

    recoveredImage = I_sample;

    temp = recoveredImage;

    itercount = 0;
    

    while(itercount<maxiter)

        recoveredImageThisIter = recoveredImage;

        itercount = itercount+1;

        for i = 1:n
            for j = 1:n
                if pixelifsampled(i,j) ==0

                    if i == 1 && i < n && j == 1 && j < n
                    we = 1/sqrt((temp(i,j+1)-temp(i,j))^2+(temp(i,j)+temp(i,j+1)-temp(i+1,j)-temp(i+1,j+1))^2/16+0.1);
                    ws = 1/sqrt((temp(i+1,j)-temp(i,j))^2+(temp(i,j+1)+temp(i+1,j+1)-temp(i,j)-temp(i+1,j))^2/16+0.1);
                    hoe = we/(we+ws);
                    hos = ws/(we+ws);
                    recoveredImageThisIter(i,j) = hoe*temp(i,j+1)+hos*temp(i+1,j);

                    elseif i == 1 && i < n && j >1 && j < n
                    we = 1/sqrt((temp(i,j+1)-temp(i,j))^2+(temp(i,j)+temp(i,j+1)-temp(i+1,j)-temp(i+1,j+1))^2/16+0.1);                
                    ww = 1/sqrt((temp(i,j)-temp(i,j-1))^2+(temp(i,j)+temp(i,j-1)-temp(i+1,j)-temp(i+1,j-1))^2/16+0.1);                
                    ws = 1/sqrt((temp(i+1,j)-temp(i,j))^2+(temp(i,j+1)+temp(i+1,j+1)-temp(i,j-1)-temp(i+1,j-1))^2/16+0.1);             
                    hoe = we/(we+ww+ws);                
                    how = ww/(we+ww+ws);                              
                    hos = ws/(we+ww+ws);              
                    recoveredImageThisIter(i,j) = hoe*temp(i,j+1)+how*temp(i,j-1)+hos*temp(i+1,j);   

                    elseif i == 1 && i < n && j >1 && j == n              
                    ww = 1/sqrt((temp(i,j)-temp(i,j-1))^2+(temp(i,j-1)+temp(i,j)-temp(i+1,j)-temp(i+1,j-1))^2/16+0.1);                              
                    ws = 1/sqrt((temp(i+1,j)-temp(i,j))^2+(temp(i,j)+temp(i+1,j)-temp(i,j-1)-temp(i+1,j-1))^2/16+0.1);                           
                    how = ww/(ww+ws);                               
                    hos = ws/(ww+ws);              
                    recoveredImageThisIter(i,j) = how*temp(i,j-1)+hos*temp(i+1,j);

                    elseif i > 1 && i < n && j ==1 && j < n
                    we = 1/sqrt((temp(i,j+1)-temp(i,j))^2+(temp(i-1,j)+temp(i-1,j+1)-temp(i+1,j)-temp(i+1,j+1))^2/16+0.1);                
                    wn = 1/sqrt((temp(i-1,j)-temp(i,j))^2+(temp(i-1,j+1)+temp(i,j+1)-temp(i,j)-temp(i-1,j))^2/16+0.1);                
                    ws = 1/sqrt((temp(i+1,j)-temp(i,j))^2+(temp(i,j+1)+temp(i+1,j+1)-temp(i,j)-temp(i+1,j))^2/16+0.1);             
                    hoe = we/(we+wn+ws);                              
                    hon = wn/(we+wn+ws);                
                    hos = ws/(we+wn+ws);              
                    recoveredImageThisIter(i,j) = hoe*temp(i,j+1)+hon*temp(i-1,j)+hos*temp(i+1,j);  

                    elseif i > 1 && i < n && j > 1 && j == n
                    ww = 1/sqrt((temp(i,j)-temp(i,j-1))^2+(temp(i-1,j)+temp(i-1,j-1)-temp(i+1,j)-temp(i+1,j-1))^2/16+0.1);                
                    wn = 1/sqrt((temp(i-1,j)-temp(i,j))^2+(temp(i-1,j)+temp(i,j)-temp(i,j-1)-temp(i-1,j-1))^2/16+0.1);                
                    ws = 1/sqrt((temp(i+1,j)-temp(i,j))^2+(temp(i,j)+temp(i+1,j)-temp(i,j-1)-temp(i+1,j-1))^2/16+0.1);                             
                    how = ww/(ww+wn+ws);                
                    hon = wn/(ww+wn+ws);                
                    hos = ws/(ww+wn+ws);              
                    recoveredImageThisIter(i,j) = how*temp(i,j-1)+hon*temp(i-1,j)+hos*temp(i+1,j);             

                    elseif i == n && i > 1 && j == 1 && j < n
                    we = 1/sqrt((temp(i,j+1)-temp(i,j))^2+(temp(i-1,j)+temp(i-1,j+1)-temp(i,j)-temp(i,j+1))^2/16+0.1);                      
                    wn = 1/sqrt((temp(i-1,j)-temp(i,j))^2+(temp(i-1,j+1)+temp(i,j+1)-temp(i,j)-temp(i-1,j))^2/16+0.1);                            
                    hoe = we/(we+wn);                               
                    hon = wn/(we+wn);                            
                    recoveredImageThisIter(i,j) = hoe*temp(i,j+1)+hon*temp(i-1,j);

                    elseif i == n && i > 1 && j >1 && j < n
                    we = 1/sqrt((temp(i,j+1)-temp(i,j))^2+(temp(i-1,j)+temp(i-1,j+1)-temp(i,j)-temp(i,j+1))^2/16+0.1);                
                    ww = 1/sqrt((temp(i,j)-temp(i,j-1))^2+(temp(i-1,j)+temp(i-1,j-1)-temp(i,j)-temp(i,j-1))^2/16+0.1);                
                    wn = 1/sqrt((temp(i-1,j)-temp(i,j))^2+(temp(i-1,j+1)+temp(i,j+1)-temp(i,j-1)-temp(i-1,j-1))^2/16+0.1);                
                    hoe = we/(we+ww+wn);                
                    how = ww/(we+ww+wn);                
                    hon = wn/(we+ww+wn);                             
                    recoveredImageThisIter(i,j) = hoe*temp(i,j+1)+how*temp(i,j-1)+hon*temp(i-1,j);      

                    elseif i == n && i > 1 && j >1 && j == n
                    ww = 1/sqrt((temp(i,j)-temp(i,j-1))^2+(temp(i-1,j)+temp(i-1,j-1)-temp(i,j)-temp(i,j-1))^2/16+0.1);                
                    wn = 1/sqrt((temp(i-1,j)-temp(i,j))^2+(temp(i-1,j)+temp(i,j)-temp(i,j-1)-temp(i-1,j-1))^2/16+0.1);                                         
                    how = ww/(ww+wn);                
                    hon = wn/(ww+wn);             
                    recoveredImageThisIter(i,j) = how*temp(i,j-1)+hon*temp(i-1,j);  

                    else                
                    we = 1/sqrt((temp(i,j+1)-temp(i,j))^2+(temp(i-1,j)+temp(i-1,j+1)-temp(i+1,j)-temp(i+1,j+1))^2/16+0.1);                
                    ww = 1/sqrt((temp(i,j)-temp(i,j-1))^2+(temp(i-1,j)+temp(i-1,j-1)-temp(i+1,j)-temp(i+1,j-1))^2/16+0.1);                
                    wn = 1/sqrt((temp(i-1,j)-temp(i,j))^2+(temp(i-1,j+1)+temp(i,j+1)-temp(i,j-1)-temp(i-1,j-1))^2/16+0.1);                
                    ws = 1/sqrt((temp(i+1,j)-temp(i,j))^2+(temp(i,j+1)+temp(i+1,j+1)-temp(i,j-1)-temp(i+1,j-1))^2/16+0.1);             
                    hoe = we/(we+ww+wn+ws);                
                    how = ww/(we+ww+wn+ws);                
                    hon = wn/(we+ww+wn+ws);                
                    hos = ws/(we+ww+wn+ws);              
                    recoveredImageThisIter(i,j) = hoe*temp(i,j+1)+how*temp(i,j-1)+hon*temp(i-1,j)+hos*temp(i+1,j);   
                    end               
                end
            end
        end
       


        temp = recoveredImageThisIter;
        disp(['iter ']);
        disp(itercount);

    end


    reconsturctionresult = temp;
    figure(1);
    imshow(reconsturctionresult,[0 255]);

end