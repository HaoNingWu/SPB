
clear; close all
clc



        fontsizet = 24;
        fontsizea = 18;
        fontsizel = 28;

%% parameter settingss
M = 128; N = 512;   % matrix dimension M-by-N
% M = 64; N = 256;   
% M = 100; N = 2000;
% M = 128; N = 1024;

Trial = 100; % trial times

matrix_type = 1;
% matrix_type = 1: RIP matrices (Gaussian and partial DCT)
% matrix_type = 2: highly coherent matrices (oversampled partial DCT without minimum separation and oversampled 
%   DCT with minimum separation L=2F)

minK = 25; maxK = 65; inter = 2;
% minK =20; maxK =  65; inter = 1;
% minK = 5; maxK =  45; inter = 2;

addon = minK - 2;
I = (maxK-minK+2)/2;

switch matrix_type 
    case 1
        parfor i = 1:I
            [SR1(i),SR2(i),SR3(i),SR4(i),SR5(i),SR6(i),MSE1(i),MSE2(i),MSE3(i),MSE4(i),MSE5(i),MSE6(i)] = safeguardedalphaforPC(i,M,N,Trial,1,1,addon)
        end
    case 2
        parfor i = 1:I
            [SR1(i),SR2(i),SR3(i),SR4(i),SR5(i),SR6(i),MSE1(i),MSE2(i),MSE3(i),MSE4(i),MSE5(i),MSE6(i)] = safeguardedalphaforPC(i,M,N,Trial,3,1,addon)
        end
end


figure(1)
axes('position',[0.05,0.1,0.45,.88])

        plot(minK:inter:maxK,SR2,'-s','LineWidth',1.2,'MarkerSize',16), hold on,...
            plot(minK:inter:maxK,SR3,'-d','LineWidth',1.25,'MarkerSize',16),...
            plot(minK:inter:maxK,SR4,'-^','LineWidth',1.8,'MarkerSize',20),...
            plot(minK:inter:maxK,SR5,'-o','LineWidth',1.2,'MarkerSize',16),...
            plot(minK:inter:maxK,SR6,'-<','LineWidth',1.25,'MarkerSize',16),...
            plot(minK:inter:maxK,SR1,'--p','LineWidth',1.5,'MarkerSize',18),...
                set(gca, 'fontsize', fontsizea),
            xlabel('sparsity $s$','interpreter','latex','FontSize',fontsizel+4),...
            ylabel('success rate','interpreter','latex','FontSize',fontsizel+8),...
            set(legend('$\alpha=0.2$','$\alpha=0.4$','$\alpha=0.6$','$\alpha=0.8$','$\alpha = 1$','$\alpha=0.7$ with safeguard'),'interpreter','latex','fontsize',22,'location','best'),
 
figure(2)
h = plot(1:10,1:10,1:10,1:10,1:10,1:10,1:10,1:10,1:10,1:10,1:10,1:10);
c = get(h,'Color');

figure(1)
axes('position',[0.55,0.57,0.42,.41])
     plot(minK:inter:maxK,log(MSE4),'-^','LineWidth',1.8,'MarkerSize',20,'color',c{3}), hold on,...
            plot(minK:inter:maxK,log(MSE5),'-o','LineWidth',1.2,'MarkerSize',16,'color',c{4}),...
            plot(minK:inter:maxK,log(MSE6),'-<','LineWidth',1.25,'MarkerSize',16,'color',c{5}),...
                set(gca, 'fontsize', fontsizea),
            ylabel('relative error (log scale)','interpreter','latex','FontSize',fontsizel), set(legend('$\alpha=0.6$','$\alpha=0.8$','$\alpha = 1$'),'interpreter','latex','fontsize',22,'location','best'),

 axes('position',[0.55,0.1,0.42,.41])
  plot(minK:inter:maxK,log(MSE2),'-s','LineWidth',1.2,'MarkerSize',16,'color',c{1}), hold on,...
            plot(minK:inter:maxK,log(MSE3),'-d','LineWidth',1.25,'MarkerSize',16,'color',c{2}),...
            plot(minK:inter:maxK,log(MSE1),'--p','LineWidth',1.5,'MarkerSize',18,'color',c{6}),...
                set(gca, 'fontsize', fontsizea),
            xlabel('sparsity $s$','interpreter','latex','FontSize',fontsizel+4),...
            ylabel('relative error (log scale)','interpreter','latex','FontSize',fontsizel), set(legend('$\alpha=0.2$','$\alpha=0.4$','$\alpha=0.7$ with safeguard'),'interpreter','latex','fontsize',22,'location','best'),