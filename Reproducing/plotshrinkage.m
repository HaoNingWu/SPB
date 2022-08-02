close all, clear all
s = 59;
y = linspace(-1,1,s);
thr = .25;
mu = .75; 
alpha = 1/mu;
alpha2 = 0.15;
beta = 1;

ysoft = wthresh(y,'s',thr);
yhard = wthresh(y,'h',thr);
yfirm = firm(y,thr,mu);
ysb = sb(y,thr,alpha);
yp = abs(y).^(.5);
ytl1 = (1+beta).*abs(y)./(beta+abs(y));


for i = 1:s
    if abs(y(i)) <= mu
        ymcp(i) = abs(y(i)) - abs(y(i))^2/(2*mu);
    else
        ymcp(i) = mu/2;
    end
end
ymcp = ymcp / (mu/2);

ysb = (abs(y) - alpha/2*abs(y).^2)/(1-alpha/2);

ysb2 = (abs(y) - alpha2/2*abs(y).^2)/(1-alpha2/2);


axes('position',[0.04,0.09,0.45,.86]),
plot(y,abs(y),'-ko','linewidth',1.5,'MarkerSize',15), hold on,...
    plot(y,yp,'-*','linewidth',1.5,'MarkerSize',15),
    plot(y,ytl1,'-<','linewidth',1.5,'MarkerSize',15),
    plot(y,ymcp,'-d','linewidth',1.5,'MarkerSize',15),
    plot(y,ysb,'-h','linewidth',1.5,'MarkerSize',15),
    plot(y,ysb2,'-+','linewidth',1.5,'MarkerSize',15),
    set(gca, 'fontsize', 18),
    xlabel('$x$','interpreter','latex','fontsize',30)
ylim([0 1.2]), title('\textbf{various penalties}','interpreter','latex','fontsize',24), %xlabel('$w$','interpreter','latex','FontSize',18),
set(legend('L1','Lp, $p=0.5$', 'TL1, $\beta=1$','MCP, $\mu=0.75$','SPB, $\alpha=1/\mu$','SPB, $\alpha=0.15$'),'interpreter','latex','FontSize',18,'location','best')



y = linspace(-1.5,1.5,1000);
thr = 0.25;
mu = 0.75; 
alpha = 1/mu;

ysoft = wthresh(y,'s',thr);
yhard = wthresh(y,'h',thr);
yfirm = firm(y,thr,mu);
ysb = sb(y,thr,alpha);

yscad = scad(y,thr,3);

ytl1 = tl1(y,thr,1);




axes('position',[0.52,0.56,0.21,.39]),
plot(y,y,'--','linewidth',2.5), hold on, plot(y,ysoft,'linewidth',2.5)
        set(gca, 'fontsize', 18),
ylim([-1.5 1.5]), title('\textbf{soft thresholding (for L1)}','interpreter','latex','fontsize',24), %xlabel('$w$','interpreter','latex','FontSize',18),
set(legend('$w$','${\rm{soft}}(w;\lambda)$'),'interpreter','latex','FontSize',18,'location','northwest')



axes('position',[0.76,0.56,0.21,.39]),
plot(y,y,'--','linewidth',2.5), hold on, plot(y,ytl1,'linewidth',2.5)
        set(gca, 'fontsize', 18),
ylim([-1.5 1.5]), title('\textbf{transformed $\ell_1$ thresholding (for TL1)}','interpreter','latex','fontsize',24), %xlabel('$w$','interpreter','latex','FontSize',18),
set(legend('$w$','${\rm{TL1}}(w;\lambda,\beta)$'),'interpreter','latex','FontSize',18,'location','northwest')


axes('position',[0.52,0.09,0.21,.39]),
plot(y,y,'--','linewidth',2.5), hold on, plot(y,yfirm,'linewidth',2.5)
        set(gca, 'fontsize', 18),
ylim([-1.5 1.5]), title('\textbf{firm thresholding (for MCP)}','interpreter','latex','fontsize',24), %xlabel('$w$','interpreter','latex','FontSize',18),
set(legend('$w$','${\rm{firm}}(w;\lambda,\mu)$'),'interpreter','latex','FontSize',18,'location','northwest')
xlabel('$w$','interpreter','latex','fontsize',30)



axes('position',[0.76,0.09,0.21,.39]),
plot(y,y,'--','linewidth',2.5), hold on, plot(y,ysb,'-','linewidth',2.5)
        set(gca, 'fontsize', 18),
ylim([-1.5 1.5]), title('\textbf{springback thresholding (for SPB)}','interpreter','latex','fontsize',24), %xlabel('$w$','interpreter','latex','FontSize',18),
set(legend('$w$','${\rm{springback}}(w;\lambda,\alpha)$'),'interpreter','latex','FontSize',18,'location','northwest')
xlabel('$w$','interpreter','latex','fontsize',30)







function yfirm = firm(y,thr,mu) 
    [m,n] = size(y);
    for i = 1:max(m,n)
        if abs(y(i)) <= thr
            yfirm(i) = 0;
        elseif abs(y(i)) >= thr && abs(y(i)) <= mu
            yfirm(i) = sign(y(i))*mu*(abs(y(i))-thr)/(mu-thr);
        else
            yfirm(i) = y(i); 
        end
    end
end



function yscad = scad(y,thr,gamma) 
    [m,n] = size(y);
    for i = 1:max(m,n)
        if abs(y(i)) <= 2*thr
            yscad(i) = wthresh(y(i),'s',thr);
        elseif abs(y(i)) >= 2*thr && abs(y(i)) <= gamma*thr
            yscad(i) = (gamma-1)/(gamma-2) *  wthresh(y(i),'s',gamma*thr/(gamma-1));
        else
            yscad(i) = y(i);
        end
    end
end



function ytl1 = tl1(y,thr,beta) 
    [m,n] = size(y);
    for i = 1:max(m,n)
        if abs(y(i)) <= thr*(beta+1)/beta
            ytl1(i) = 0;
        else
            ytl1(i) = g(y(i),thr,beta);
        end
    end
end



function gl = g(y,thr,beta)
    phi = acos(1-27*thr*beta*(beta+1)/2/(beta+abs(y))^3);
    gl = sign(y)*(2/3*(beta+abs(y))*cos(phi/3)-2*beta/3+abs(y)/3);
end



function ysb = sb(y,thr,alpha) 
    [m,n] = size(y);
    for i = 1:max(m,n)
        if abs(y(i)) <= thr
            ysb(i) = 0;
        else
            ysb(i) = sign(y(i))*(abs(y(i))-thr)/(1-thr*alpha);
        end
    end
end