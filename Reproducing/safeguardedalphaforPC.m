function [SR1,SR2,SR3,SR4,SR5,SR6,MSE1,MSE2,MSE3,MSE4,MSE5,MSE6] = safeguardedalphaforPC(i,M,N,Trial,matrixtype,supptype,addon)

% 
n = 1;

K = 2*i + addon;
matrix_idx = matrixtype;
supp_idx = supptype;

for trial = 1:Trial % 100


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


% parameters
pm.lambda = 1e-6;
pm.maxit = 500;
pm.reltol = 1e-5;
pmL1 = pm; 
pmL1.maxit = 5000;
if cond(A) <= 5
    desalpha = min(2*min(svd(A))/norm(b),.7);
else
    desalpha = max(0.5,min(2*min(svd(A))/norm(b),.7));
end

[x1,~]   = DCA_SPBconstrained( A, b, pm, desalpha);
[x2,~]  = DCA_SPBconstrained( A, b, pm, .2);
[x3,~]  = DCA_SPBconstrained( A, b, pm, .4);
[x4,~]  = DCA_SPBconstrained( A, b, pm, .6);
[x5,~]  = DCA_SPBconstrained( A, b, pm, .8);
[x6,~]  = DCA_SPBconstrained( A, b, pm, 1);
        
        
% compute MSE
xall = [x1,x2,x3,x4,x5,x6];
for k = 1:size(xall,2)  
    xx = xall(:,k);
    MSE(trial, k) =norm(xx-x_ref,2)/norm(x_ref,2);
    if MSE(trial, k) < 1e-3
        SucRate(trial,k) = 1;
    else
        SucRate(trial,k) = 0;
    end
end

fprintf(['K=',num2str(K),' trial=',num2str(trial), ' alpha = ', num2str(desalpha),'\n'])
end

MSE1 = mean(MSE(:,1));
MSE2 = mean(MSE(:,2));
MSE3 = mean(MSE(:,3));
MSE4 = mean(MSE(:,4));
MSE5 = mean(MSE(:,5));
MSE6 = mean(MSE(:,6));


SR1 = sum(SucRate(:,1))/Trial;
SR2 = sum(SucRate(:,2))/Trial;
SR3 = sum(SucRate(:,3))/Trial;
SR4 = sum(SucRate(:,4))/Trial;
SR5 = sum(SucRate(:,5))/Trial;
SR6 = sum(SucRate(:,6))/Trial;

end
