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

% RK4 method
for i = 2:length(t_range)
    t = t_range(i - 1);
    y = y_values(i - 1);
    
    % Runge-Kutta coefficients
    k1 = h * dydt(t, y);
    k2 = h * dydt(t + h/2, y + k1/2);
    k3 = h * dydt(t + h/2, y + k2/2);
    k4 = h * dydt(t + h, y + k3);
    
    % Update y using RK4 method
    y_new = y + (k1 + 2*k2 + 2*k3 + k4)/6;
    
    % Store the results
    y_values(i) = y_new;
end

% Display the final result
final_result = y_values(end);
disp(['Final result at t = 1: y = ' num2str(final_result)]);
