% Given data points
x_values = [1.0, 2.0, 3.0, 4.0];
y_values = [0.0, 1.0, 8.0, 27.0];

% Interpolation point
x_interp = 2.5;

% Newton's interpolating polynomial coefficients
n = length(x_values);
f = zeros(n, n);
f(:, 1) = y_values';

for j = 2:n
    for i = j:n
        f(i, j) = (f(i, j-1) - f(i-1, j-1)) / (x_values(i) - x_values(i-j+1));
    end
end

coefficients = diag(f);

% Evaluate the interpolating polynomial at x_interp
P = coefficients(1);
for i = 2:n
    term = 1;
    for j = 1:i-1
        term = term * (x_interp - x_values(j));
    end
    P = P + coefficients(i) * term;
end

disp(['Interpolated value at x = 2.5: ' num2str(P)]);
