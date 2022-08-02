
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
    [SucRate(i),MSE(i)] = demoforPC(i,M,N,Trial,1,addon)
end

 axes('position',[0.04,0.55,0.3,.4]),
plot(minK:inter:maxK,SucRate,'-d','LineWidth',1.2,'MarkerSize',16), hold on,...
    set(gca, 'fontsize', fontsizea),
    title('$\mathbf{64\times160}$ \textbf{Gaussian}','interpreter','latex','FontSize',fontsizet),
    ylabel('success rate','interpreter','latex','FontSize',fontsizel), set(legend('Springback'),'interpreter','latex','fontsize',15), box on
