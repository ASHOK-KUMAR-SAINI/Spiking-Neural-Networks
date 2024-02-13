

% Define the number of generators
n = input('Enter the number of generators: ');

% Define the coefficients of the fuel-cost function for each generator
c = zeros(n, 3);
for i = 1:n
    fprintf('Enter the coefficients for generator %d:\n', i);
    c(i, 1) = input('\alpha : ');
    c(i, 2) = input('\beta: ');
    c(i, 3) = input('\gama: ');
end


% Define the real power loss expression (if considered)
%pL = @(p) 0.218 * p(1)^2 + 0.0228 * p(2)^2 + 0.0179 * p(3)^2;
PowerLoss = zeros(n, 1);
include_losses = input('Include losses (1 = yes, 0 = no): ');
if include_losses
    for i = 1:n
        fprintf('Enter the power loss coefficient for generator %d:\n', i);
        PowerLoss(i) = input('PL: ');
    end
end
% Define the total system load
PD = input('Enter the total load: ');

include_limits = input('Include generator limits (1 = yes, 0 = no): ');
limits = zeros(n, 2);
if include_limits
    % lower and upper limits for each generator
    for i = 1:n
        fprintf('Enter the lower and upper limits for generator %d:\n', i);
        limits(i, 1) = input('Lower limit: ');
        limits(i, 2) = input('Upper limit: ');
    end
else
limits(:, 1) = zeros(n, 1);
limits(:, 2) = ones(n, 1) * PD;
end
% Initialize the generator outputs
p = zeros(n, 1);

% Define the optimization options
options = optimoptions('fmincon', 'Display', 'iter');

% Define the optimization function
fun = @(p) calcCost(p, c, PD, PowerLoss, limits);

% Run the optimization algorithm
[pOpt, costOpt] = fmincon(fun, p, [], [], ones(1, n), PD, limits(:, 1), limits(:, 2), [], options);

% Display the optimal dispatch and total cost
disp(['Optimal Dispatch: ' num2str(pOpt')]);
disp(['Total Cost: ' num2str(costOpt) ' Rs./h']);

% Subfunction to calculate the cost
function cost = calcCost(p, c, PD, PowerLoss, limits)
    % Check for generator limits
    for i = 1:length(p)
        if p(i) < limits(i, 1) || p(i) > limits(i, 2)
            cost = inf;
            return;
        end
    end
    
    % Calculate the total cost
    cost = 0;
    for i = 1:length(p)
        cost = cost + c(i, 1) + c(i, 2) * p(i) + c(i, 3) * p(i)^2;
    end
    
    % Add the power loss term (if considered)
    if nargin == 4
         PL=0;
    for i = 1:length(p)
        PL=PL+PowerLoss(i)*p(i)*p(i);
    end
        cost = cost + PL;
    end 
end
