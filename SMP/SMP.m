%-----------------------------------------------------------------------
%  SMP --------------------------------------------------------------


%  inputs
%  I_sample        - sampled image (the size should be n^2)
%  pixelifsampled  - knowledgement matrix (the size should be n^2, if pixel i,j is 
%                               known pixelifsampled(i,j) = 1, else pixelifsampled(i,j)=0)
%  maxiter         - max value of # iter

%  output
%  Ir  -  reconstruction result (with size n^2)
% YUFAN LUO 2016/7/5



function [ Ir ] = SMP( I_sample,pixelifsampled,maxiter)

    pixelifsampled = PixelMatrixToVector(pixelifsampled);
    I_sample = PixelMatrixToVector(I_sample).*pixelifsampled;
    
    

    N = length(pixelifsampled);
    n = sqrt(N);
    m = length(find(pixelifsampled>0.5));

    J_hat = PixelMatrixToVector(dct2(PixelVectorToMatrix(I_sample,[n n])));

    DMT = dctmtx(n)';
    
    J_recover = zeros(N,1);

    setCover = [];

    k = 1;


    while(k<=maxiter)

        [a b] = max(abs(J_hat));

        vb = zeros(N,1);
        
        
        pp = floor((b-1)/n)+1;
        qq = mod(b,n);
        if qq == 0
            qq = n;
        end
        
        targetVec = pixelifsampled.*kron(DMT(:,pp),DMT(:,qq));
        
        
        
        T = PixelMatrixToVector(dct2(PixelVectorToMatrix(targetVec, [n n])));



        J_recover(b) = J_hat(b)/T(b);
        setCover(end+1)=b;


        J_hat = J_hat - T*J_recover(b);

        J_hat(setCover)=0;

        k = k+1


    end

    Ir = idct2(PixelVectorToMatrix(J_recover, [n n]));

    figure(1);
    imshow(Ir,[0 255]);




end
