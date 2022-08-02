
clear all; close all
clc


Trial = 100; % trial times


        fontsizet = 24;
        fontsizea = 18;
        fontsizel = 36;


% ----------------Set 1---------------

M = 64; N = 160;   % matrix dimension M-by-N
minK = 6; maxK = 40; inter = 2;

addon = minK - 2;
I = (maxK-minK+2)/2;


parfor i = 1:I            
    [SucRateAIHT(i),SucRateL1(i),SucRateLp(i),SucRateTL1(i),SucRateL12(i),SucRateMCP(i),SucRateSPB(i),MSEAIHT(i),MSEL1(i),MSELp(i),MSETL1(i),MSEL12(i),MSEMCP(i),MSESPB(i)] = noisefreetestonRIPmatricesforPC(i,M,N,Trial,1,addon)
end

 axes('position',[0.04,0.55,0.3,.4]),
plot(minK:inter:maxK,SucRateAIHT,'-d','LineWidth',1.2,'MarkerSize',16), hold on,...
    plot(minK:inter:maxK,SucRateL1,'-o','LineWidth',1.25,'MarkerSize',16), hold on,...
    plot(minK:inter:maxK,SucRateLp,'-s','LineWidth',1.8,'MarkerSize',20),...
    plot(minK:inter:maxK,SucRateTL1,'-<','LineWidth',1.2,'MarkerSize',16),...
    plot(minK:inter:maxK,SucRateL12,'-^','LineWidth',1.25,'MarkerSize',16),...
    plot(minK:inter:maxK,SucRateMCP,'-*','LineWidth',1.25,'MarkerSize',16),...
    plot(minK:inter:maxK,SucRateSPB,'--p','LineWidth',1.5,'MarkerSize',18),...
    set(gca, 'fontsize', fontsizea),
    title('$\mathbf{64\times160}$ \textbf{Gaussian}','interpreter','latex','FontSize',fontsizet),
    ylabel('success rate','interpreter','latex','FontSize',fontsizel), set(legend('AIHT','ADMM-$\ell_1$','IRLS-$\ell_p$','DCA-TL1','DCA-$\ell_{1-2}$','DCA-MCP','Springback'),'interpreter','latex','fontsize',15), box on


parfor i = 1:I
    [SucRateAIHT(i),SucRateL1(i),SucRateLp(i),SucRateTL1(i),SucRateL12(i),SucRateMCP(i),SucRateSPB(i),MSEAIHT(i),MSEL1(i),MSELp(i),MSETL1(i),MSEL12(i),MSEMCP(i),MSESPB(i)]  = noisefreetestonRIPmatricesforPC(i,M,N,Trial,2,addon)        
end



axes('position',[0.04,0.07,0.3,.4]),
plot(minK:inter:maxK,SucRateAIHT,'-d','LineWidth',1.2,'MarkerSize',16), hold on,...
    plot(minK:inter:maxK,SucRateL1,'-o','LineWidth',1.25,'MarkerSize',16), hold on,...
    plot(minK:inter:maxK,SucRateLp,'-s','LineWidth',1.8,'MarkerSize',20),...
    plot(minK:inter:maxK,SucRateTL1,'-<','LineWidth',1.2,'MarkerSize',16),...
    plot(minK:inter:maxK,SucRateL12,'-^','LineWidth',1.25,'MarkerSize',16),...
    plot(minK:inter:maxK,SucRateMCP,'-*','LineWidth',1.25,'MarkerSize',16),...
    plot(minK:inter:maxK,SucRateSPB,'--p','LineWidth',1.5,'MarkerSize',18),...
    set(gca, 'fontsize', fontsizea),
    title('$\mathbf{64\times160}$ \textbf{partial DCT}','interpreter','latex','FontSize',fontsizet),
    ylabel('success rate','interpreter','latex','FontSize',fontsizel), 
    xlabel('sparsity $s$','interpreter','latex','FontSize',fontsizel), 
    set(legend('AIHT','ADMM-$\ell_1$','IRLS-$\ell_p$','DCA-TL1','DCA-$\ell_{1-2}$','DCA-MCP','Springback'),'interpreter','latex','fontsize',15), box on

% % ----------------Set 2---------------


M = 64; N = 320;   % matrix dimension M-by-N
minK = 6; maxK = 40; inter = 2;
addon = minK - 2;
I = (maxK-minK+2)/2;



parfor i = 1:I            
    [SucRateAIHT(i),SucRateL1(i),SucRateLp(i),SucRateTL1(i),SucRateL12(i),SucRateMCP(i),SucRateSPB(i),MSEAIHT(i),MSEL1(i),MSELp(i),MSETL1(i),MSEL12(i),MSEMCP(i),MSESPB(i)]  = noisefreetestonRIPmatricesforPC(i,M,N,Trial,1,addon)
end

 axes('position',[0.365,0.55,0.3,.4]),
plot(minK:inter:maxK,SucRateAIHT,'-d','LineWidth',1.2,'MarkerSize',16), hold on,...
    plot(minK:inter:maxK,SucRateL1,'-o','LineWidth',1.25,'MarkerSize',16), hold on,...
    plot(minK:inter:maxK,SucRateLp,'-s','LineWidth',1.8,'MarkerSize',20),...
    plot(minK:inter:maxK,SucRateTL1,'-<','LineWidth',1.2,'MarkerSize',16),...
    plot(minK:inter:maxK,SucRateL12,'-^','LineWidth',1.25,'MarkerSize',16),...
    plot(minK:inter:maxK,SucRateMCP,'-*','LineWidth',1.25,'MarkerSize',16),...
    plot(minK:inter:maxK,SucRateSPB,'--p','LineWidth',1.5,'MarkerSize',18),...
    set(gca, 'fontsize', fontsizea),
    title('$\mathbf{64\times320}$ \textbf{Gaussian}','interpreter','latex','FontSize',fontsizet),
    set(legend('AIHT','ADMM-$\ell_1$','IRLS-$\ell_p$','DCA-TL1','DCA-$\ell_{1-2}$','DCA-MCP','Springback'),'interpreter','latex','fontsize',15), box on

   
   
parfor i = 1:I
    [SucRateAIHT(i),SucRateL1(i),SucRateLp(i),SucRateTL1(i),SucRateL12(i),SucRateMCP(i),SucRateSPB(i),MSEAIHT(i),MSEL1(i),MSELp(i),MSETL1(i),MSEL12(i),MSEMCP(i),MSESPB(i)]  = noisefreetestonRIPmatricesforPC(i,M,N,Trial,2,addon)        
end


axes('position',[0.365,0.07,0.3,.4]),

plot(minK:inter:maxK,SucRateAIHT,'-d','LineWidth',1.2,'MarkerSize',16), hold on,...
    plot(minK:inter:maxK,SucRateL1,'-o','LineWidth',1.25,'MarkerSize',16), hold on,...
    plot(minK:inter:maxK,SucRateLp,'-s','LineWidth',1.8,'MarkerSize',20),...
    plot(minK:inter:maxK,SucRateTL1,'-<','LineWidth',1.2,'MarkerSize',16),...
    plot(minK:inter:maxK,SucRateL12,'-^','LineWidth',1.25,'MarkerSize',16),...
    plot(minK:inter:maxK,SucRateMCP,'-*','LineWidth',1.25,'MarkerSize',16),...
    plot(minK:inter:maxK,SucRateSPB,'--p','LineWidth',1.5,'MarkerSize',18),...
    set(gca, 'fontsize', fontsizea),
    title('$\mathbf{64\times320}$ \textbf{partial DCT}','interpreter','latex','FontSize',fontsizet),
    xlabel('sparsity $s$','interpreter','latex','FontSize',fontsizel), 
    set(legend('AIHT','ADMM-$\ell_1$','IRLS-$\ell_p$','DCA-TL1','DCA-$\ell_{1-2}$','DCA-MCP','Springback'),'interpreter','latex','fontsize',15), box on


% ----------------Set 3---------------



M = 64; N = 640;   % matrix dimension M-by-N
minK = 6; maxK = 40; inter = 2;
addon = minK - 2;
I = (maxK-minK+2)/2;


parfor i = 1:I            
    [SucRateAIHT(i),SucRateL1(i),SucRateLp(i),SucRateTL1(i),SucRateL12(i),SucRateMCP(i),SucRateSPB(i),MSEAIHT(i),MSEL1(i),MSELp(i),MSETL1(i),MSEL12(i),MSEMCP(i),MSESPB(i)]  = noisefreetestonRIPmatricesforPC(i,M,N,Trial,1,addon)
end

axes('position',[0.69,0.55,0.3,.4]),

plot(minK:inter:maxK,SucRateAIHT,'-d','LineWidth',1.2,'MarkerSize',16), hold on,...
    plot(minK:inter:maxK,SucRateL1,'-o','LineWidth',1.25,'MarkerSize',16), hold on,...
    plot(minK:inter:maxK,SucRateLp,'-s','LineWidth',1.8,'MarkerSize',20),...
    plot(minK:inter:maxK,SucRateTL1,'-<','LineWidth',1.2,'MarkerSize',16),...
    plot(minK:inter:maxK,SucRateL12,'-^','LineWidth',1.25,'MarkerSize',16),...
    plot(minK:inter:maxK,SucRateMCP,'-*','LineWidth',1.25,'MarkerSize',16),...
    plot(minK:inter:maxK,SucRateSPB,'--p','LineWidth',1.5,'MarkerSize',18),...
    set(gca, 'fontsize', fontsizea),
    title('$\mathbf{64\times640}$ \textbf{Gaussian}','interpreter','latex','FontSize',fontsizet),
    set(legend('AIHT','ADMM-$\ell_1$','IRLS-$\ell_p$','DCA-TL1','DCA-$\ell_{1-2}$','DCA-MCP','Springback'),'interpreter','latex','fontsize',15), box on

 
   
parfor i = 1:I
    [SucRateAIHT(i),SucRateL1(i),SucRateLp(i),SucRateTL1(i),SucRateL12(i),SucRateMCP(i),SucRateSPB(i),MSEAIHT(i),MSEL1(i),MSELp(i),MSETL1(i),MSEL12(i),MSEMCP(i),MSESPB(i)]  = noisefreetestonRIPmatricesforPC(i,M,N,Trial,2,addon)        
end


axes('position',[0.69,0.07,0.3,.4]),
plot(minK:inter:maxK,SucRateAIHT,'-d','LineWidth',1.2,'MarkerSize',16), hold on,...
    plot(minK:inter:maxK,SucRateL1,'-o','LineWidth',1.25,'MarkerSize',16), hold on,...
    plot(minK:inter:maxK,SucRateLp,'-s','LineWidth',1.8,'MarkerSize',20),...
    plot(minK:inter:maxK,SucRateTL1,'-<','LineWidth',1.2,'MarkerSize',16),...
    plot(minK:inter:maxK,SucRateL12,'-^','LineWidth',1.25,'MarkerSize',16),...
    plot(minK:inter:maxK,SucRateMCP,'-*','LineWidth',1.25,'MarkerSize',16),...
    plot(minK:inter:maxK,SucRateSPB,'--p','LineWidth',1.5,'MarkerSize',18),...
    set(gca, 'fontsize', fontsizea),
    title('$\mathbf{64\times640}$ \textbf{partial DCT}','interpreter','latex','FontSize',fontsizet),
    xlabel('sparsity $s$','interpreter','latex','FontSize',fontsizel), 
    set(legend('AIHT','ADMM-$\ell_1$','IRLS-$\ell_p$','DCA-TL1','DCA-$\ell_{1-2}$','DCA-MCP','Springback'),'interpreter','latex','fontsize',15), box on

