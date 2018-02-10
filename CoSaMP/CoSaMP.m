 function [ Ir ] = CoSaMP( I_sample,pixelifsampled,numCofficients,maxiter)
 
 
if nargin < 4
    maxiter = 40;
end
 

ALG_converge=[];
currentSet = [];

I_sample = PixelMatrixToVector(I_sample);
pixelifsampled = PixelMatrixToVector(pixelifsampled);

N = length(pixelifsampled);
n = sqrt(N);

I_sampleWOzeros = I_sample(find(pixelifsampled>0.5));



v = I_sample;

maxiter = 30;

for iter = 1:maxiter
    
    y = dct(v);
    
    
    [a b] = sort(abs(y),'descend');
    b = b([1:numCofficients*2]);
    
    currentSet = union(b,currentSet);
    

    
    A = @(x,mode) sampleIDCT_inside(x,currentSet,pixelifsampled,mode);

    x_hat = lsqr(A,I_sampleWOzeros,[],2220);
    
    
    [a b] = sort(abs(x_hat),'descend');
    
    b = b([1:numCofficients]);
    
    currentSet = currentSet(b);
      
    x_hat = x_hat(b);
    
    t = zeros(N,1);
    t(currentSet) = x_hat;
    t = idct(t);
    
    if iter<maxiter
        t = t(find(pixelifsampled>0.5));
        t = I_sampleWOzeros - t;
        v = zeros(N,1);
        v(find(pixelifsampled>0.5))=t;        
    end
    
    
    
    if iter>1
        ALG_converge(end+1) = length(intersect(currentSet,previousSet));
    end
    
    previousSet = currentSet;
    
end

preKnowledge = currentSet;

Ir = PixelVectorToMatrix(t,[n n]);

figure(1)
imshow(Ir,[0 255]);





 end





