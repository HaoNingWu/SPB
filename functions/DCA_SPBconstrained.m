function [x_new,iter] = DCA_SPBconstrained( A, b, pm, alpha)


% set matrix handles
Ahandle = @(x) A*x;
AThandle = @(x) A'*x;

% initialization
[M, N] = size(A);


if isfield(pm,'lambda')
    lambda = pm.lambda; 
else
    lambda = 1e-5;  % default value
end


if isfield(pm,'mu')
    mu = pm.mu; 
else
    mu = 1e5;  % default value
end

% parameter for ADMM
if isfield(pm,'delta')
    delta = pm.delta; 
else
%     delta = 10 * lambda;
delta = 50;
end

% maximum number of iterations
if isfield(pm,'maxit')
    maxit = pm.maxit; 
else 
    maxit = 5*N; % default value
end

% initial guess
if isfield(pm,'x0');
    x0 = pm.x0; 
else 
    x0 = zeros(N,1); % initial guess
end

if isfield(pm,'reltol')
    reltol = pm.reltol; 
else 
    reltol  = 1e-6; 
end

iter = 0;


AAt     = A*A';
AtA     = A'*A;
ACD     = A'*A + delta * diag(ones(N,1));
L       = chol(speye(M) + 1/((delta/mu))*AAt, 'lower');
L       = sparse(L);
U       = sparse(L');   

x       = zeros(N,1);
Atb     = A'*b;


x_old = x0;
x_new = x_old;
x = x0; y = x0; z = x0; u = x0; 
z = zeros(M,1); lamb = z;


while iter < 10
    
    x_old = x_new;
    xi = alpha * x_old;
    
    
    for it = 1:maxit       
        xold = x;
        
         rhs     = mu*(Atb+A'*z -A'*lamb) + xi +delta * (y -u);
        
        x       =(1/mu)*( rhs/(delta/mu) - (A'*(U\(L\(A*rhs))))/(delta/mu)^2);

        y = shrink(x+u,1/delta);
        
        z = zeros(M,1); % projection: zero if tau = 0; 

        u = u + (x-y);
       
        lamb = lamb +( (A*x -b)-z);


       relerr      = norm(xold - x)/max([norm(xold), norm(x), eps]);

        if relerr < reltol
            break;
        end 
        
    
end
    
x_new = x;
    
    
% check for termination
if norm(x_new - x_old)/max(1,norm(x_new)) < reltol
    iter = iter + 1;
    break
end
    
   iter = iter + 1;
    
end











