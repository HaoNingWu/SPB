function [SucRate,MSE] = demoforPC(i,M,N,Trial,matrixtype,addon)

    K = 2*i + addon;
    matrix_idx = matrixtype;

    for trial = 1:Trial

    switch matrix_idx
        case 1
            A   = randn(M,N); 
            A   = orth(A')';    % normalize each column to be zero mean and unit norm
        case 2      
            A = zeros(M,N);
            r = rand(M,1);
            l = 1:N;
            for k = 1:M
                A(k,:) = sqrt(2/M) * cos(2 * pi * r(k) * (l-1));
            end
    end

    idx = randperm(N);
    supp = idx(1:K);
    x_ref = zeros(N,1); % ground truth
    xs = randn(K,1);
    x_ref(supp) = xs;
    As = A(:,supp);
    b = A * x_ref;
        
    % parameters
    pm.lambda = 1e-6;
    pm.maxit = 500;
    pm.reltol = 1e-5;
   
    if cond(A) <= 5
        desalpha = min(2*min(svd(A))/norm(b),.7);
    else
        desalpha = max(0.5,min(2*min(svd(A))/norm(b),.7));
    end
    [xSPB,~]   =  DCA_SPBconstrained( A, b, pm, desalpha);

  
 
    MSE(trial) =norm(xSPB-x_ref,2)/norm(x_ref,2);
    if MSE(trial) < 1e-3
        SucRate(trial) = 1;
    else
        SucRate(trial) = 0;
    end
    fprintf(['M=',num2str(M), ' N=',num2str(N), ' MATTYPE=',num2str(matrix_idx) ' K=',num2str(K),' trial=',num2str(trial), ' alpha=', num2str(desalpha),'\n'])
    end

MSE = mean(MSE);


SucRate = sum(SucRate)/Trial;


end
