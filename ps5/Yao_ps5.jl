using LinearAlgebra, Random, Distributions, Statistics, Loess
###########Problem 1##############
N = 400; # number of observations
T = 401; # time of replictions

E = zeros(T,4);
for i = 1:T
    x = 2*rand(N).-1
    epsilon = randn(N);
    y = 0.5 .+ x .+ epsilon;
    model = loess(x, y, degree = 1); # local linear regression
    y0 = predict(model, [0.0])[1];
    y1 = predict(model, [maximum(x)])[1];
    E[i,1] = y0 - 0.5; # bias at x=0
    E[i,2] = (y0-0.5)^2; # squared error at x=0
    E[i,3] = y1 - 1.5; # bias at x=1
    E[i,4] = (y1-1.5)^2; # squared error at x=1
end
bias1 = mean(E[:,1]);
bias2 = mean(E[:,3]);
rmse1 = sqrt(mean(E[:,2]));
rmse2 = sqrt(mean(E[:,4]));

println("The mean bias of E[y|x=0] is:", bias1)
println("\nThe RMSE of E[y|x=0] is:", rmse1)
println("\nThe mean bias of E[y|x=1] is:", bias2)
println("\nThe RMSE of E[y|x=1] is:", rmse2)