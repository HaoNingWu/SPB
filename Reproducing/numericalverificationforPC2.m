function [convrate,MSEL1,MSEL12,MSESPB] = numericalverificationforPC2(i,N,K,Trial,matrixtype,supptype,addon)



dB = 45;


M = 2*i + addon;


matrix_idx = matrixtype;
supp_idx = supptype;

for trial = 1:Trial


switch matrix_idx
    case 1
        A   = randn(M,N); 
        A   = orth(A')';  
    case 2          
        A = zeros(M,N);
        r = rand(M,1);
        l = 1:N;
        for k = 1:M
            A(k,:) = sqrt(2/M) * cos(2 * pi * r(k) * (l-1));
        end
    case 3 
        F = 10;
        A = zeros(M,N);
        r = rand(M,1);
        l = 1:N;
        for k = 1:M
            A(k,:) = sqrt(2/M) * cos(2 * pi * r(k) * (l-1) / F);
        end
    case 4
        F = 20; 
        A = zeros(M,N);
        r = rand(M,1);
        l = 1:N;
        for k = 1:M
            A(k,:) = sqrt(2/M) * cos(2 * pi * r(k) * (l-1) / F);
        end
end

switch supp_idx
    case 1
        idx         = randperm(N);
        supp        = idx(1:K);
    case 2       
        supp        = randsample_separated(N,K,2*F); 
end

x_ref       = zeros(N,1); % ground truth
xs          = randn(K,1);
x_ref(supp) = xs;
As          = A(:,supp);
sigma       = 0.1;
b           = A * x_ref;
b = awgn(b,dB);


% parameters
pm.lambda = 1e-6;
pm.maxit = 500;
pm.reltol = 1e-3;
pmL1 = pm; 
pmL1.maxit = 5000;
        

[xL1,~]      = ADMM_L1(A,b,pmL1);             
[xL12,~]   = DCA_L12(A,b,pm);        
if cond(A) <= 5
    desalpha = min(2*min(svd(A))/norm(b),.7);
else
    desalpha = max(0.4,min(2*min(svd(A))/norm(b),.7));
end
        
pm.tau = norm(A*x_ref-b);
[xSPB,~]   =  DCA_SPBconstrainednoisy( A, b, pm, desalpha);


        
% compute MSE
xall = [xL1, xL12, xSPB];
for k = 1:size(xall,2)  
    xx = xall(:,k);
    MSE(trial, k) =norm(xx-x_ref,2)/norm(x_ref,2);
end

        
       
fprintf(['M=',num2str(M), ' N=',num2str(N), ' MATTYPE=',num2str(matrix_idx) ' s=',num2str(K),' trial=',num2str(trial), ' alpha=', num2str(desalpha),'\n'])
end

DIV = MSE(:, 3) > 10*MSE(:,1);
convrate = (Trial-sum(DIV))/Trial;

MSEL1 = mean(MSE(:,1));
MSEL12 = mean(MSE(:,2));
vMSESPB = MSE(:,3); vMSESPB(DIV) = [];
MSESPB = mean(vMSESPB);

end
