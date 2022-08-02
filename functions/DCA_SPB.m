function [x_new,iter] = DCA_SPB( A, b, pm, alpha)


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

% parameter for ADMM
if isfield(pm,'delta'); 
    delta = pm.delta; 
else
    delta = 10 * lambda;
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
L       = chol(speye(M) + 1/delta*AAt, 'lower');
L       = sparse(L);
U       = sparse(L');   

x       = zeros(N,1);
Atb     = A'*b;


x_old = x0;
x_new = x_old;
x = x0; y = x0; u = x0;

while iter < 10
    
    x_old = x_new;
    xi = (lambda * alpha ) * x_old;
    
    
    for it = 1:maxit       
        xold = x;
         rhs     = Atb + xi +delta * y -u;
          x       = rhs/(delta) - (A'*(U\(L\(A*rhs))))/(delta)^2;

          y = shrink(x+u/delta,lambda/delta);
        
          u = u + delta*(x-y);
       
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











