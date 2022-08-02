function [convrate,MSEAIHT,MSEL1,MSELp,MSETL1,MSEL12,MSEMCP,MSESPB,MSESPBno] = noisytestonRIPandoverDCTforPC(i,M,N,K,Trial,matrixtype,supptype,addon)



dB = 3*i + addon;


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
        F = 8;
        A = zeros(M,N);
        r = rand(M,1);
        l = 1:N;
        for k = 1:M
            A(k,:) = sqrt(2/M) * cos(2 * pi * r(k) * (l-1) / F);
        end
    case 4
        F = 16; 
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
b           = A * x_ref;
b = awgn(b,dB);


% parameters
pm.lambda = 1e-6;
pm.maxit = 500;
pm.reltol = 1e-3;
pmL1 = pm; 
pmL1.maxit = 5000;
         
[xAIHT, ~, ~]=AIHT(b,A,N,K);
[xL1,~]      = ADMM_L1(A,b,pmL1);
[xL12,~]   = DCA_L12(A,b,pm);           
if cond(A) <= 5
    desalpha = min(2*min(svd(A))/norm(b),.7);
else
    desalpha = max(0.4,min(2*min(svd(A))/norm(b),.7)); 
end

pm.tau = norm(A*x_ref - b);
[xSPB,~]   =  DCA_SPBconstrainednoisy( A, b, pm, desalpha);

desalpha2 = min(2*min(svd(A))/norm(b),.7);
[xSPB2,~]   =  DCA_SPBconstrainednoisy( A, b, pm, desalpha2);

[xMCP,~]   =  DCA_MCP( A, b, pm, 1/desalpha);
pmp.x0 = zeros(N,1);
[xIRLS,Out] = IRucLq_v(A,b,1e-6,.5,pmp);
xTL1 = DCA_TL1(A,b,pm,zeros(N,1));
        
% compute MSE
xall = [xAIHT,xL1, xIRLS, xTL1, xL12,xMCP,xSPB,xSPB2];
for k = 1:size(xall,2)  
    xx = xall(:,k);
    MSE(trial, k) =norm(xx-x_ref,2)/norm(x_ref,2);
    if MSE(trial, k) < 1e-3
        SucRate(trial,k) = 1;
    else
        SucRate(trial,k) = 0;
    end
end
        
fprintf(['M=',num2str(M), ' N=',num2str(N), ' MATTYPE=',num2str(matrix_idx) ' dB=',num2str(dB),' trial=',num2str(trial), ' alpha=', num2str(desalpha),'\n'])
end



DIV = MSE(:, 7) > 10*MSE(:,2);
convrate = (Trial-sum(DIV))/Trial;


MSEAIHT = mean(MSE(:,1));
MSEL1 = mean(MSE(:,2));
MSELp = mean(MSE(:,3));
MSETL1 = mean(MSE(:,4));
MSEL12 = mean(MSE(:,5));
MSEMCP = mean(MSE(:,6));

vMSESPB = MSE(:,7); vMSESPB(DIV) = [];
MSESPB = mean(vMSESPB);

MSESPBno = mean(MSE(:,8));



end
