#include <stdio.h>

double dividedDifference(double x, double x_values[], double y_values[], int start, int end) {
    if (start == end) {
        return y_values[start];
    } else {
        return (dividedDifference(x, x_values, y_values, start + 1, end) - dividedDifference(x, x_values, y_values, start, end - 1)) / (x_values[end] - x_values[start]);
    }
}

double newtonInterpolation(double x, double x_values[], double y_values[], int n) {
    double result = 0.0;
    double term = 1.0;

    for (int i = 0; i <= n; ++i) {
        result += term * dividedDifference(x, x_values, y_values, 0, i);
        term *= (x - x_values[i]);
    }

    return result;
}

