function [SucRateAIHT,SucRateL1,SucRateLp,SucRateTL1,SucRateL12,SucRateMCP,SucRateSPB,MSEAIHT,MSEL1,MSELp,MSETL1,MSEL12,MSEMCP,MSESPB]  = noisefreetestonoverDCTforPC(i,M,N,F,Trial,addon)



K = 2*i + addon;


for trial = 1:Trial

A = zeros(M,N);
r = rand(M,1);
l = 1:N;
for k = 1:M
        A(k,:) = sqrt(2/M) * cos(2 * pi * r(k) * (l-1) / F);
end
 
        

supp = randsample_separated(N,K,2*F); 
x_ref = zeros(N,1); % grounf truth
xs = randn(K,1);
x_ref(supp) = xs;
As = A(:,supp);
b = A * x_ref;
        
% parameters
pm.lambda = 1e-6;
pm.maxit = 500;
pm.reltol = 1e-5;
pmL1 = pm; 
pmL1.maxit = 5000;

[xAIHT, ~, ~]=AIHT(b,A,N,K);
[xL1,~]      = ADMM_L1(A,b,pmL1);
[xL12,~]   = DCA_L12(A,b,pm);
if cond(A) <= 5
    desalpha = min(2*min(svd(A))/norm(b),.7);
else
    desalpha = max(0.5,min(2*min(svd(A))/norm(b),.7));
end
[xSPB,~]   =  DCA_SPBconstrained( A, b, pm, desalpha);
[xMCP,~]   =  DCA_MCP( A, b, pm, 1/desalpha);
pmp.x0 = zeros(N,1);
[xIRLS,Out] = IRucLq_v(A,b,1e-6,.5,pmp);
xTL1 = DCA_TL1(A,b,pm,zeros(N,1));


% compute MSE
xall = [xAIHT,xL1, xIRLS, xTL1, xL12,xMCP,xSPB];
for k = 1:size(xall,2)  
    xx = xall(:,k);
    MSE(trial, k) =norm(xx-x_ref,2)/norm(x_ref,2);
    if MSE(trial, k) < 1e-3
        SucRate(trial,k) = 1;
    else
        SucRate(trial,k) = 0;
    end
end

fprintf(['F=',num2str(F), ' K=',num2str(K),' trial=',num2str(trial), ' alpha=', num2str(desalpha),'\n'])
end


MSEAIHT = mean(MSE(:,1));
MSEL1 = mean(MSE(:,2));
MSELp = mean(MSE(:,3));
MSETL1 = mean(MSE(:,4));
MSEL12 = mean(MSE(:,5));
MSEMCP = mean(MSE(:,6));
MSESPB = mean(MSE(:,7));


SucRateAIHT = sum(SucRate(:,1))/Trial;
SucRateL1 = sum(SucRate(:,2))/Trial;
SucRateLp = sum(SucRate(:,3))/Trial;
SucRateTL1 = sum(SucRate(:,4))/Trial;
SucRateL12 = sum(SucRate(:,5))/Trial;
SucRateMCP = sum(SucRate(:,6))/Trial;
SucRateSPB = sum(SucRate(:,7))/Trial;

end
