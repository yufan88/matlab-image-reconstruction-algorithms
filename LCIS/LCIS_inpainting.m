%-----------------------------------------------------------------------
%  LCIS inpainting described in ------------------------------------------
%  this program is designed for LCIS image inpainting reconstruction
%  this program is only used for black - white images
%  Yufan Luo - 2016/7/5

%  inputs
%  I_sample        - sampled image (the size should be n*m)
%  pixelifsampled  - knowledgement matrix (the size should be n*m, if pixel i,j is 
%                               known E(i,j) = 1, else E(i,j)=0)
%  maxiter         - max value of # iter (optional, default 30000)
%  stepsize        - step size of iteration (optional, default 0.05)
%  errtol          - error tolerance (optional, default 2e-4)

%  output
%  reconsturctionresult  -  reconstruction (with size n*m)



function [ reconsturctionresult ] = LCIS_inpainting( I_sample, pixelifsampled, maxiter, stepsize, errtol)


    if length(size(I_sample)) > 2
        I_sample = rgb2gray(I_sample);
    end

    if nargin < 3
        maxiter = 30000;
    end

    
    if nargin < 4
        stepsize = 0.05;
    end
    
    
    if nargin < 5
        errtol = 2e-4;
    end
    
    [n m] = size(pixelifsampled);
    
    
    c1 = 1.5;
    c2 = 360;
    lambda = 350;
    
    
    % compute d matrix
    
    Al = bandedmatrix(n);
    Ar = bandedmatrix(m);

    temp = dct2(Al);

    eigenvalues1 = zeros(n,1);
    for i = 1:n
        eigenvalues1(i) = temp(i,i);
    end
    
    temp = dct2(Ar);

    eigenvalues2 = zeros(m,1);
    for i = 1:m
        eigenvalues2(i) = temp(i,i);
    end

    temp = [];


    deltasquare = zeros(n,m);
    for i = 1:n
        for j = 1:m

            deltasquare(i,j) = (eigenvalues1(i)+eigenvalues2(j))^2;

        end
    end

    d = ones(n,m)+ones(n,m)*stepsize*c2+deltasquare*stepsize*c1;
    
    
    % --------------
    
    E = pixelifsampled;

    count = 0;
    
    U0 = I_sample;
    
    while(count<maxiter)
    
        temp = zeros(n,m);
        hU0 = dct2(U0);
        tempatan = atan((U0*Ar+Al*U0)/0.3);
        tempatan = -Al*tempatan-tempatan*Ar;
        tempatan = tempatan*stepsize;

        templambda = E.*(I_sample-U0)*lambda*stepsize;


        t = hU0+dct2(tempatan+templambda)+stepsize*c1*deltasquare.*hU0+c2*stepsize*hU0;

        temp = t./d;

        tempname = idct2(temp);

        if max(max(abs(U0-tempname))) < errtol
            U0 = tempname;
            break;
        end

        U0 = tempname;

        count = count + 1;
        
        if ~mod(count,100)
            disp(['iter ']);
            disp(count);
        end
        
        
    end


    reconsturctionresult = U0;
    


end

