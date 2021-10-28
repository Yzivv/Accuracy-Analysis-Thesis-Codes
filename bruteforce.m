%% Calculates the Brute-force approximation of the diameter using piece-wise constant 
%% elements of the admissible data.
%%
%% INPUT: 
%%      a_mean : function handle of central alpha
%%      b_mean : function handle of central beta
%%      f_mean : function handle of central f
%%      delta1 : function handle of indeterminacy of alpha
%%      delta2 : ---||--- beta
%%      delta3 : ---||--- f
%%      domain : [a,b], domain of the problem
%%      bdcond : [A,B], boundary conditions of the problem
%%      sol_amount : how large the subset of the solution cloud made is
%%      mesh_points : how many points subintervals we allow for the piecewise coefficients

function approx = bruteforce(a_mean,b_mean,f_mean,delta1,delta2,delta3,domain,bdcond,sol_amount,mesh_points)
    
    N = sol_amount-mod(sol_amount,24)+24;
    n = N/3;
    N = N+8;
    u_cells = cell(N,1);
    du_cells = cell(N,1);
    
    %% Creating the discrete "stepwise" version of the admissible data strip
    
    a_min = @(x) a_mean(x)-delta1(x);
    a_max = @(x) a_mean(x)+delta1(x);
    
    b_min = @(x) b_mean(x)-delta2(x);
    b_max = @(x) b_mean(x)+delta2(x);
    
    f_min = @(x) f_mean(x)-delta3(x);
    f_max = @(x) f_mean(x)+delta3(x);
    
    
    ai = zeros(2,mesh_points-1);
    bi = zeros(2,mesh_points-1);
    fi = zeros(2,mesh_points-1);
    
    X = linspace(domain(1),domain(2),mesh_points);
    
    for k = 1:mesh_points-1
        ai(:,k) = [a_min(fminbnd(@(x) -a_min(x),X(k),X(k+1))),a_max(fminbnd(a_max,X(k),X(k+1)))];
        bi(:,k) = [b_min(fminbnd(@(x) -b_min(x),X(k),X(k+1))),b_max(fminbnd(b_max,X(k),X(k+1)))];
        fi(:,k) = [f_min(fminbnd(@(x) -f_min(x),X(k),X(k+1))),f_max(fminbnd(f_max,X(k),X(k+1)))];
    end
    
    
    %% Creating first a third of the solutions with completely random coefficients
    
    a1 = zeros(n,mesh_points-1);
    b1 = zeros(n,mesh_points-1);
    f1 = zeros(n,mesh_points-1);
    
    for k = 1:mesh_points-1
        
        a1(:,k) = (ai(2,k)-ai(1,k)).*rand(n,1) + ai(1,k);
        b1(:,k) = (bi(2,k)-bi(1,k)).*rand(n,1) + bi(1,k);
        f1(:,k) = (fi(2,k)-fi(1,k)).*rand(n,1) + fi(1,k);
        
    end
    
    for k = 1:n
        [u_cells{k}, du_cells{k}] = SolverPieceConst(a1(k,:),b1(k,:),f1(k,:),linspace(0,1,mesh_points),bdcond);
    end
    
    
    %% Another third with maximally high or low values of indeterminacy
    %% This maximizes the oscillation of the solutions
    
    a2 = zeros(n,mesh_points-1);
    b2 = zeros(n,mesh_points-1);
    f2 = zeros(n,mesh_points-1);
    
    for k = 1:mesh_points-1
        
        a2(:,k) = (ai(2,k)-ai(1,k)).*(randi(2,n,1)-1) + ai(1,k);
        b2(:,k) = (bi(2,k)-bi(1,k)).*(randi(2,n,1)-1) + bi(1,k);
        f2(:,k) = (fi(2,k)-fi(1,k)).*(randi(2,n,1)-1) + fi(1,k);
        
    end
    
    for h = 1:n
        k = h+n;
        [u_cells{k}, du_cells{k}] = SolverPieceConst(a2(h,:),b2(h,:),f2(h,:),linspace(0,1,mesh_points),bdcond);
    end    
        
    
    %% The last third is made by picking the indeterminacies in eight different ranges
    %% Each possible combination has the value of a,b,f at either high or low values
    %% so a total of eight combinations.
    %% This maximizes the area between solutions.
    
    a3 = zeros(n,mesh_points-1);
    b3 = zeros(n,mesh_points-1);
    f3 = zeros(n,mesh_points-1);
    
    options = dec2bin(0:2^3-1)' - '0';
    
    for k=1:8
        op = options(:,k);
        for d = 1:mesh_points-1
            a3(:,d) = (ai(2,d)-ai(1,d)).*(rand(n,1).*0.1 + op(1)*0.9)+ai(1,d);
            b3(:,d) = (bi(2,d)-bi(1,d)).*(rand(n,1).*0.1 + op(2)*0.9)+bi(1,d);
            f3(:,d) = (fi(2,d)-fi(1,d)).*(rand(n,1).*0.1 + op(3)*0.9)+fi(1,d);
        end
    end
    
    for h = 1:n
        k = h+2*n;
        [u_cells{k}, du_cells{k}] = SolverPieceConst(a3(h,:),b3(h,:),f3(h,:),linspace(0,1,mesh_points),bdcond);
    end
    
    %% Finally we add 8 solutions for which we pick the absolute max and min value combinations
    
    a4 = zeros(8,mesh_points-1);
    b4 = zeros(8,mesh_points-1);
    f4 = zeros(8,mesh_points-1);
    
    for k=1:8
        op = options(:,k);
        a4(k,:) = (ai(2,:)-ai(1,:))*op(1)+ai(1,:);
        b4(k,:) = (bi(2,:)-bi(1,:))*op(2)+bi(1,:);
        f4(k,:) = (fi(2,:)-fi(1,:))*op(3)+fi(1,:);
    end
    
    for h = 1:8
        k = h+3*n;
        [u_cells{k}, du_cells{k}] = SolverPieceConst(a4(h,:),b4(h,:),f4(h,:),linspace(0,1,mesh_points),bdcond);
    end
    
    
    %% Calculating the supremum of the norm over the subset of the solution set
    
    I_mat = zeros(N,N);
    for k = N:-1:1
        for h = 1:k
            if h ~= k
                I_mat(h,k) = energyAB2(linspace(domain(1),domain(2)),u_cells{k},du_cells{k},u_cells{h},du_cells{h},a_mean,b_mean);
            end
        end
    end
    
    approx = max(max(I_mat));
    
    
    
    
    
    