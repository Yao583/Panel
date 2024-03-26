cd("/Users/luoyao/Downloads/GitHub/Panel/ps4")
% simulate data y=max(alpha+beta*x+epsilon,0)
alpha = 0.5;
beta  = 1.0;
n   = 100; % number of observations
N   = 400; % number of simulations
x   = randn(n);
epsilon = randn(n);
ystar = alpha + beta * x + epsilon;
d = (ystar > 0);
stats = zeros(N,2); % to calculate bias of alpha and beta
for i = 1:N

    % construct the objective function and optimization
    obj = @(b) mean((d - (sqrt(1-b^2) + b*x > 0))'*(d - (sqrt(1-b^2) + b*x > 0)));
    b0 = [0.0]; % initial guess of the parameters
    [bmin,fval] = fminsearch(obj, b0);
    stats(i,1) = bmin - beta;
    stats(i,2) = (bmin - beta)^2;

end
mbias = mean(stats(:,1));
mse   = mean(stats(:,2));
% Display the result
disp(["The mean bias for 100 observations is ", num2str(mbias)]);
disp(["The MSE for 100 observations is ", num2str(mse)]);