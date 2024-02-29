cd("/Users/luoyao/Downloads/GitHub/Panel/ps3")

% true parameter values
alpha0 = 0.5;
beta0 = 1;
n = 400;
stats = zeros(n,2);
% data generation
N = 100;
for i = 1:n
    X = randn(N);
    epsilon = randn(N);
    y = max(alpha0 + X*beta0 + epsilon, 0);
    X0 = X(y==0);
    X1 = X(y>0);
    y0 = y(y==0);
    y1 = y(y>0);
    % define the negative loglikelihood function
    func = @(theta) -sum(log(normcdf(-X0*theta(2)-theta(1))))-...
    sum(log(normpdf(y1-X1*theta(2)-theta(1))));

    % initial guess
    x0 = [0, 0];
    % find the minimizer of the negative loglikelihood function
    [xmin,fval] = fminsearch(func, x0);
    stats(i,1) = xmin(1) - alpha0;
    stats(i,2) = xmin(2) - beta0;
end

mbias = mean(stats);
mse   = sqrt(mean(stats'*stats));
% Display the result
disp(["The mean bias for 100 observations is ", num2str(mbias)]);
disp(["The MSE for 100 observations is ", num2str(mse)]);

N = 200;
for i = 1:n
    X = randn(N);
    epsilon = randn(N);
    y = max(alpha0 + X*beta0 + epsilon, 0);
    X0 = X(y==0);
    X1 = X(y>0);
    y0 = y(y==0);
    y1 = y(y>0);
    % define the negative loglikelihood function
    func = @(theta) -sum(log(normcdf(-X0*theta(2)-theta(1))))-...
    sum(log(normpdf(y1-X1*theta(2)-theta(1))));

    % initial guess
    x0 = [0, 0];
    % find the minimizer of the negative loglikelihood function
    [xmin,fval] = fminsearch(func, x0);
    stats(i,1) = xmin(1) - alpha0;
    stats(:,2) = xmin(2) - beta0;
end

mbias = mean(stats);
mse   = sqrt(mean(stats'*stats));
% Display the result
disp(["The mean bias for 200 observations is ", num2str(mbias)]);
disp(["The MSE for 200 observations is ", num2str(mse)]);

N = 400;
for i = 1:n
    X = randn(N);
    epsilon = randn(N);
    y = max(alpha0 + X*beta0 + epsilon, 0);
    X0 = X(y==0);
    X1 = X(y>0);
    y0 = y(y==0);
    y1 = y(y>0);
    % define the negative loglikelihood function
    func = @(theta) -sum(log(normcdf(-X0*theta(2)-theta(1))))-...
    sum(log(normpdf(y1-X1*theta(2)-theta(1))));

    % initial guess
    x0 = [0, 0];
    % find the minimizer of the negative loglikelihood function
    [xmin,fval] = fminsearch(func, x0);
    stats(i,1) = xmin(1) - alpha0;
    stats(:,2) = xmin(2) - beta0;
end

mbias = mean(stats);
mse   = sqrt(mean(stats'*stats));
% Display the result
disp(["The mean bias for 400 observations is ", num2str(mbias)]);
disp(["The MSE for 400 observations is ", num2str(mse)]);
