% Define the ODE
dydt = @(t, y) exp(y*t);

% Define the initial condition
y0 = 0;

% Define the step size
h = 0.1;

% Define the range of t values
t_range = 0: h: 1;

% Initialize arrays to store the results
y_values = zeros(size(t_range));

% Set initial value
y_values(1) = y0;

% Euler's method
for i = 2:length(t_range)
    t = t_range(i - 1);
    y = y_values(i - 1);
    
    % Update y using Euler's method
    y_new = y + h * dydt(t, y);
    
    % Store the results
    y_values(i) = y_new;
end

% Display the final result
final_result = y_values(end);
disp(['Final result at t = 1: y = ' num2str(final_result)]);
