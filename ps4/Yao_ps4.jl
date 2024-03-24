using Distributions, NLopt, LinearAlgebra, Random

# generate dataset
a = 0.5;
b = 1.0;
size = 100; # number of observations
x = randn(size);
epsilon = randn(size);
y = max.(a .+ x*b .+ epsilon, 0);
d = Int.(a .+ x*b .+ epsilon .> 0);

# Maximum Score estimator
function MS(d,x,β)
    i = Int.(sqrt(1-β^2) .+ β*x .> 0);
    return -mean((2*d.-1).*i)
end

β_initial = [0.0];

opt = Opt(:LN_COBYLA, 1) # 1 is the number of parameters in β
lower_bounds!(opt, [-1.0])
upper_bounds!(opt, [1.0])


function MS_bias(N)
    E = zeros(N,2);
    for i = 1:N
        min_objective!(opt, (β,grad) -> MS(d,x,β[1]))
        xtol_rel!(opt, 1e-10)
        result = NLopt.optimize(opt, β_initial)
        β_ms = result[2]
        E[i,1] = β_ms[1] - b;
        E[i,2] = (β_ms[1] - b)^2;
    end
    mb = mean(E[:,1]);
    mse = mean(E[:,2]);
    return mb, mse
end

result1 = MS_bias(100)
result2 = MS_bias(200)
result3 = MS_bias(400)

# Maximum Rank estimator
