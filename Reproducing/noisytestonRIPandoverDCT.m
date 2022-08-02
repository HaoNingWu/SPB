
clear all; close all
clc

%% parameter settings

        fontsizet = 24;
        fontsizea = 18;
        fontsizel = 30;


Trial = 100; % trial times

M = 64; N = 128;
mindB = 15; maxdB = 60; inter = 3;


addon = mindB - 3;
I = (maxdB-mindB+3)/3;

K = 25;

parfor i = 1:I
    [convrate(i),MSEAIHT(i),MSEL1(i),MSELp(i),MSETL1(i),MSEL12(i),MSEMCP(i),MSESPB(i),MSESPBno(i)] = noisytestonRIPandoverDCTforPC(i,M,N,K,Trial,1,1,addon)
end



axes('position',[0.05,0.3,0.42,.65]),
plot(mindB:inter:maxdB,log(MSEAIHT),'-d','LineWidth',1.2,'MarkerSize',16), hold on,...
        plot(mindB:inter:maxdB,log(MSEL1),'-o','LineWidth',1.25,'MarkerSize',16), hold on,...
            plot(mindB:inter:maxdB,log(MSELp),'-s','LineWidth',1.8,'MarkerSize',20),...           
            plot(mindB:inter:maxdB,log(MSETL1),'-<','LineWidth',1.2,'MarkerSize',16),...
            plot(mindB:inter:maxdB,log(MSEL12),'-^','LineWidth',1.25,'MarkerSize',16),...
             plot(mindB:inter:maxdB,log(MSEMCP),'-*','LineWidth',1.25,'MarkerSize',16),...
            plot(mindB:inter:maxdB,log(MSESPB),'--p','LineWidth',1.5,'MarkerSize',18),...
    set(gca, 'fontsize', fontsizea), set(gca,'xticklabel',[]),...
            title('$\mathbf{64\times128}$ \textbf{Gaussian}, $\mathbf{s=25}$','interpreter','latex','FontSize',22),
            ylabel('relative error (log scale)','interpreter','latex','FontSize',fontsizel),  
    set(legend('AIHT','ADMM-$\ell_1$','IRLS-$\ell_p$','DCA-TL1','DCA-$\ell_{1-2}$','DCA-MCP','Springback'),'interpreter','latex','fontsize',20), box on
        
axes('position',[0.05,0.1,0.42,.18]),
plot(mindB:inter:maxdB,convrate,'-p','LineWidth',1.25,'MarkerSize',18,'color',[143,0,35]/255),...
                set(gca, 'fontsize', fontsizea),
    ylim([0,1]),...
    xlabel('SNR (dB)','interpreter','latex','FontSize',fontsizel), ylabel('acceptance rate','interpreter','latex','FontSize',fontsizel), 
        


M = 128; N = 1500;
mindB = 30; maxdB = 75; inter = 3;


addon = mindB - 3;
I = (maxdB-mindB+3)/3;

K = 30;

parfor i = 1:I
    [convrate(i),MSEAIHT(i),MSEL1(i),MSELp(i),MSETL1(i),MSEL12(i),MSEMCP(i),MSESPB(i),MSESPBno(i)] = noisytestonRIPandoverDCTforPC(i,M,N,K,Trial,3,2,addon);
end

axes('position',[0.55,0.3,0.42,.65]),
plot(mindB:inter:maxdB,log(MSEAIHT),'-d','LineWidth',1.2,'MarkerSize',16), hold on,...
        plot(mindB:inter:maxdB,log(MSEL1),'-o','LineWidth',1.25,'MarkerSize',16), hold on,...
            plot(mindB:inter:maxdB,log(MSELp),'-s','LineWidth',1.8,'MarkerSize',20),...           
            plot(mindB:inter:maxdB,log(MSETL1),'-<','LineWidth',1.2,'MarkerSize',16),...
            plot(mindB:inter:maxdB,log(MSEL12),'-^','LineWidth',1.25,'MarkerSize',16),...
            plot(mindB:inter:maxdB,log(MSEMCP),'-*','LineWidth',1.25,'MarkerSize',16),...
            plot(mindB:inter:maxdB,log(MSESPB),'--p','LineWidth',1.5,'MarkerSize',18),...
            plot(mindB:inter:maxdB,log(MSESPBno),'--x','LineWidth',1.5,'MarkerSize',18),...
                set(gca, 'fontsize', fontsizea), set(gca,'xticklabel',[]),...
            title('$\mathbf{128\times1500}$ \textbf{oversampled DCT with} $\mathbf{F=8}$, $\mathbf{s=30}$','interpreter','latex','FontSize',fontsizet), 
            ylabel('relative error (log scale)','interpreter','latex','FontSize',fontsizel), 
                set(legend('AIHT','ADMM-$\ell_1$','IRLS-$\ell_p$','DCA-TL1','DCA-$\ell_{1-2}$','DCA-MCP','Springback','Springback w/o effcy det.'),'interpreter','latex','fontsize',20), box on
axes('position',[0.55,0.1,0.42,.18])
plot(mindB:inter:maxdB,convrate,'-p','LineWidth',1.25,'MarkerSize',18,'color',[143,0,35]/255),...
                    set(gca, 'fontsize', fontsizea), 
    ylim([0,1]),...
    xlabel('SNR (dB)','interpreter','latex','FontSize',fontsizel), ylabel('Acceptance rate','interpreter','latex','FontSize',fontsizel), 
        

