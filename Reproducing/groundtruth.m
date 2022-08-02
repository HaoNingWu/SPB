close all, clear all

M = 64; N = 250;   % matrix dimension M-by-N


K = 22;
matrix_idx = 1;
supp_idx = 1;

noisy_idx = 1; % 1 for noise-free and 2 for noisy


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
sigma       = 0;
b           = A * x_ref;
b = awgn(b,30);


% parameters
pm.lambda = 1e-6;
pm.maxit = 500;
pm.reltol = 1e-5;
pmL1 = pm;
pmL1.maxit = 5000;
if cond(A) <= 5
    desalpha = min(2*min(svd(A))/norm(b),.7);
else
    desalpha = max(0.4,min(2*min(svd(A))/norm(b),.7));
end

mu = 1/desalpha;
tic, [xL1,~]   = ADMM_L1( A, b, pmL1); toc
tic, xTL1 = DCA_TL1(A,b,pm,zeros(N,1)); toc
tic, [xL12,~]   =  DCA_L12 ( A, b, pm); toc
tic, [xMCP,~]   =  DCA_MCP( A, b, pm,1/desalpha); toc

switch noisy_idx
    case 1
        tic, [xSPB,it]   =  DCA_SPBconstrained( A, b, pm, desalpha); toc
    case 2
        pm.tau = norm(A*x_ref-b);
        tic, [xSPB,it]   =  DCA_SPBconstrainednoisy( A, b, pm, desalpha); toc
end

      

        fontsizet = 24;
        fontsizea = 18;





axes('position',[0.05,0.55,0.27,0.4]),
stem(1:N, x_ref(1:N),'MarkerSize',10); set(gca, 'fontsize', fontsizea)
title('\textbf{ground-truth}','interpreter','latex','fontsize',fontsizet)


axes('position',[0.37,0.55,0.27,0.4]),
stem(1:N, xL1(1:N),'MarkerSize',10); set(gca, 'fontsize', fontsizea)
title(['\textbf{ADMM-}$\mathbf{\ell_1}$, $\|x^{\rm{opt}}-\bar{x}\|_2=$ ', num2str(norm(xL1-x_ref),'%.4f')],'interpreter','latex','fontsize',fontsizet)

axes('position',[0.69,0.55,0.27,0.4]),
stem(1:N, xTL1(1:N),'MarkerSize',10);  set(gca, 'fontsize', fontsizea)
title(['\textbf{DCA-TL1}, $\|x^{\rm{opt}}-\bar{x}\|_2=$ ', num2str(norm(xTL1-x_ref),'%.4f')],'interpreter','latex','fontsize',fontsizet)

axes('position',[0.05,0.07,0.27,0.4]),
stem(1:N, xL12(1:N),'MarkerSize',10); set(gca, 'fontsize', fontsizea)
title(['\textbf{DCA-}$\mathbf{\ell_{1-2}}$, $\|x^{\rm{opt}}-\bar{x}\|_2=$ ', num2str(norm(xL12-x_ref),'%.4f')],'interpreter','latex','fontsize',fontsizet)

axes('position',[0.37,0.07,0.27,0.4]),
stem(1:N, xMCP(1:N),'MarkerSize',10); set(gca, 'fontsize', fontsizea)
title(['\textbf{DCA-MCP}, $\|x^{\rm{opt}}-\bar{x}\|_2=$ ', num2str(norm(xMCP-x_ref),'%.4f')],'interpreter','latex','fontsize',fontsizet)

axes('position',[0.69,0.07,0.27,0.4]),
stem(1:N, xSPB(1:N),'MarkerSize',10); set(gca, 'fontsize', fontsizea)
title(['\textbf{DCA-springback}, $\|x^{\rm{opt}}-\bar{x}\|_2=$ ', num2str(norm(xSPB-x_ref),'%.4f')],'interpreter','latex','fontsize',fontsizet)
