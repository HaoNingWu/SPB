
clear all; close all
clc


Trial = 100; % trial times

        fontsizet = 24;
        fontsizea = 18;
        fontsizel = 30;


matrix_type = 1;

M = 50; N = 160 ;   % matrix dimension M-by-N
minK = 10; maxK = 40; inter = 1;
addon = minK - 1;
I = maxK-minK+1;






parfor i = 1:I            
    [convrate(i),MSEL1(i),MSEL12(i),MSESPB(i)] = numericalverificationforPC1(i,M,N,Trial,1,1,addon)
end




axes('position',[0.05,0.3,0.42,.65]),
    plot(minK:inter:maxK,log(MSEL1),'-o','LineWidth',1.25,'MarkerSize',16), hold on,...
    plot(minK:inter:maxK,log(MSEL12),'-^','LineWidth',1.25,'MarkerSize',16,'color',[102,160,36]/255),...
    plot(minK:inter:maxK,log(MSESPB),'--p','LineWidth',1.5,'MarkerSize',18,'color',[143,0,35]/255),...
    set(gca, 'fontsize', fontsizea), set(gca,'xticklabel',[]),...
    title('$\mathbf{50\times160}$ \textbf{Gaussian}','interpreter','latex','FontSize',fontsizet), 
    ylabel('relative error (log scale)','interpreter','latex','FontSize',fontsizel),  
    set(legend('ADMM-$\ell_1$','DCA-$\ell_{1-2}$','Springback'),'interpreter','latex','fontsize',20,'location','northeast'),  
        
axes('position',[0.05,0.1,0.42,.18]),
    plot(minK:inter:maxK,convrate,'-p','LineWidth',1.25,'MarkerSize',18,'color',[143,0,35]/255),...
    set(gca, 'fontsize', fontsizea),
    ylim([0,1]),...
    xlabel('sparsity $s$','interpreter','latex','FontSize',fontsizel), ylabel('acceptance rate','interpreter','latex','FontSize',fontsizel), 
      


N =  160;   % matrix dimension M-by-N
minM = 50; maxM = 120; inter = 2;
addon = minM - 2;
I = (maxM-minM+2)/2;


K = 20;

parfor i = 1:I
    [convrate(i),MSEL1(i),MSEL12(i),MSESPB(i)] = numericalverificationforPC2(i,N,K,Trial,1,1,addon)
end



axes('position',[0.55,0.3,0.42,.65]),        
    plot(minM:inter:maxM,log(MSEL1),'-o','LineWidth',1.25,'MarkerSize',16), hold on,...
    plot(minM:inter:maxM,log(MSEL12),'-^','LineWidth',1.25,'MarkerSize',16,'color',[102,160,36]/255),...
    plot(minM:inter:maxM,log(MSESPB),'--p','LineWidth',1.5,'MarkerSize',18,'color',[143,0,35]/255'),...
    set(gca, 'fontsize', fontsizea), set(gca,'xticklabel',[]), 
    title('\textbf{Gaussian,} $\mathbf{n=160}$, $\mathbf{s=20}$','interpreter','latex','FontSize',fontsizet), 
    ylabel('relative error (log scale)','interpreter','latex','FontSize',fontsizel),  
    set(legend('ADMM-$\ell_1$','DCA-$\ell_{1-2}$','Springback'),'interpreter','latex','fontsize',20,'location','northeast'),  
        
axes('position',[0.55,0.1,0.42,.18])
    plot(minM:inter:maxM,convrate,'-p','LineWidth',1.25,'MarkerSize',18,'color',[143,0,35]/255),...
    set(gca, 'fontsize', fontsizea),
    ylim([0,1]),...
    xlabel('number of measurements $m$','interpreter','latex','FontSize',fontsizel), ylabel('acceptance rate','interpreter','latex','FontSize',fontsizel), 
      







