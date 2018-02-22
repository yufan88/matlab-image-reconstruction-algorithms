function [Ir] = BregmanSplitwithVerticalPenalty(I,E,mu,lmda,r,maxiter,tol)

    % input
    % BregmanSplitwithVerticalPenalty is used to solve the following
    % problem:
    % min |\Psi x|_1 + \mu/2*|x|_TV{vertical}  s.t. ||\Phi x - y||_2 < \sigma
    % I - sampled image with size n*m
    % E - sample matrix with size n*m, 1 if sampled, 0 otherwise
    % lmda and r and tuning vaiables - they are turned out to be very
    % critical to the convergence
    % maxiter - max # of iteration
    % tol - allowed error
    
    % output
    % Ir - reconstrcuted image
    
    
    % Yufan Luo 1/20/2018
    
    

    I_vec = PixelMatrixToVector(I);
    E_vec = PixelMatrixToVector(E);

    [n m] = size(I);
    
    u = I_vec.*E_vec;
    w = zeros(n^2,1);
    b_w = zeros(n^2,1);
    d_y = zeros(n^2,1);
    b_y = zeros(n^2,1);
    % tol = 1;
    % mu = 0.01;
    % lmda = 0.001;
    % r = 0.01;
    y = I_vec(find(E_vec>0.5));

    B = sparse(n^2,n^2);

    for i = 1:n^2-n
        B(i,i) = 1;
        B(i,i+n) = -1;
    end


    A = sparse(n^2,n^2);

    for i = 1:n^2-n
        A(i,i) = 1;
        A(i,i+n) = -1;
    end

    A = A'*A*lmda;


    for i = 1:n^2
        if E_vec(i) > 0.5
            A(i,i) = A(i,i) + mu;
        end
        A(i,i) = A(i,i) + r;
    end


    A = inv(A);

    u_current = u;
    u_next = u_current;
    current_observation = y + 1;
    f = y;

    while(norm(current_observation-y) > tol)

        u_current = u_next;

        for i = 1:maxiter

            rhs = mu*addzeros(f,E_vec) + lmda*B'*(d_y-b_y)+r*idct(w-b_w);

            u_next = A*rhs;

            s = norm(B*u_current + b_y);

            d_y = max(s-1/lmda,0)*(B*u_current+b_y)/s;

            temp1 =  dct(u_next)+b_w;
            temp2 =  1/r;

            for j = 1:length(temp1)
                if temp1(j) > temp2
                    w(j) = temp1(j) - temp2;
                elseif temp1(j) < - temp2
                    w(j) = temp1(j) + temp2;
                else
                    w(j) = 0;
                end
            end

            b_y = b_y + B*u_next - d_y;

            b_w = b_w + dct(u_next) - w;

        end

        current_observation = u_next(find(E_vec>0.5));

        f = f + y - current_observation;
        
        Ir = u_next;

        save([pwd '/Ir.mat'],'Ir','-v7.3');

    end





end

