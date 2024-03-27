using Distributions, LinearAlgebra, Random, KernelDensity, Statistics

# generate dataset
a = 0.5;
b = 1.0;
size = 100; # number of observations

# Maximum Score estimator
function MS(d,x,β)
    i = Int.(sqrt(1-β^2) .+ β*x .> 0);
    return mean((d .-i).^2)
end

β_grid = -1.0:0.001:1.0;
function MS_bias(N)
    E = zeros(N,2);
    for i = 1:N
        x = randn(size);
        epsilon = randn(size);
        d = Int.(a .+ x*b .+ epsilon .> 0);
        min_score = Inf;
        best_β = nothing;
        for β in β_grid
            score = MS(d,x,β);
            if score < min_score
                min_score = score;
                best_β = β;
            end
        end
        E[i,1] = best_β  - b;
        E[i,2] = ( best_β- b)^2;
    end
    mb = mean(E[:,1]);
    mse = mean(E[:,2]);
    return mb, mse
end

result1 = MS_bias(100)
result2 = MS_bias(200)
result3 = MS_bias(400)

# Maximum Rank estimator
function rank(d,x,β)
    rank = 0.0;
    for i = 1:length(d)
        for j = 1:length(d)
            if i != j
                I = (d[i] - d[j] > 0)*(x[i]*β - x[j]*β > 0);
                rank += I;
            end
        end
    end
    return rank
end

β_grid = -1.0 : 0.5 : 1.0;
function MR_bias(N)
    E = zeros(N,3);
    for i = 1:N
        x = randn(size);
    epsilon = randn(size);
    d = Int.(a .+ x*b .+ epsilon .> 0);
        max_rank = -Inf;
        best_β = nothing;
        for β in β_grid
            rank_val = rank(d,x,β);
            if rank_val > max_rank
               max_rank = rank_val;
               best_β = β;
            end
        end
        E[i,1] = best_β  - b;
        E[i,2] = ( best_β- b)^2;
        E[i,3] = best_β;
    end
    
    mb = mean(E[:,1]);
    mse = mean(E[:,2]);
    β = E[:,3];
    return mb, mse,β
end
result1 = MR_bias(100)
result2 = MR_bias(200)
result3 = MR_bias(400)

###########Problem 2############
N = 400; # number of observations
T = 401; # time of replictions
bandwidth = N^(-1/5);

E = zeros(T,4);
for i = 1:T
    x = 2*rand(N).-1;
    epsilon = randn(N);
    y = 0.5 .+ x .+ epsilon;
    y0 = mean(y[abs.(x .- 0) .< bandwidth])
    y1 = mean(y[abs.(x .- 1) .< bandwidth])
    E[i,1] = y0 - 0.5;
    E[i,2] = (y0-0.5)^2;
    E[i,3] = y1 - 1.5;
    E[i,4] = (y1-1.5)^2;
end
bias1 = mean(E[:,1])
bias2 = mean(E[:,3])
rmse1 = sqrt(mean(E[:,2]))
rmse2 = sqrt(mean(E[:,4]))