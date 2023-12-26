% Define the functions
f_exp = @(x) exp(x);
f_sin = @(x) sin(x);

% Point of expansion
a = 2;

% Degree of the Taylor series
n = 3;

% Initialize result
result_exp = f_exp(a);
result_sin = f_sin(a);

% Calculate Taylor series expansions using numerical approximation
for i = 1:n
    result_exp = result_exp + (f_exp(a) / factorial(i)) * (3 - a)^i;
    result_sin = result_sin + (f_sin(a) / factorial(i)) * (3 - a)^i;
end

disp(['Taylor series for e^x at x = 3: ' num2str(result_exp)]);
disp(['Result at x = 3: ' num2str(result_exp)]);

disp(['Taylor series for sin(x) at x = 3: ' num2str(result_sin)]);
disp(['Result at x = 3: ' num2str(result_sin)]);
