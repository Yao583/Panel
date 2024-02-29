cd("/Users/luoyao/Downloads/GitHub/Panel/ps4")
% simulate data y=max(alpha+beta*x+epsilon,0)
alpha = 0.5;
beta  = 1.0;
n   = 100; % number of observations
N   = 400; % number of simulations
x   = randn(n);
epsilon = randn(n);
ystar = alpha + beta * x + epsilon;
d = (ystar >= 0);
stats = zeros(N,2); % to calculate bias of alpha and beta
for i = 1:N

    % construct the objective function and optimization
    obj = @(theta) mean((d - (theta(1) + theta(2)*x >= 0)).^2);
    theta0 = [0, 0]; % initial guess of the parameters
    [thetamin,fval] = fminsearch(obj, theta0);
    stats(i,1) = thetamin(1) - alpha;
    stats(i,2) = thetamin(2) - beta;

end
mbias = mean(stats);
mse   = sqrt(mean(stats'*stats));
% Display the result
disp(["The mean bias for 100 observations is ", num2str(mbias)]);
disp(["The MSE for 100 observations is ", num2str(mse)]);