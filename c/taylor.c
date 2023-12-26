#include <stdio.h>
#include <math.h>

typedef double (*FunctionPointer)(double);

double factorial(int n) {
    if (n == 0 || n == 1) {
        return 1.0;
    } else {
        return n * factorial(n - 1);
    }
}

double derivative(FunctionPointer f, double x, int order, double h) {
    if (order == 0) {
        return f(x);
    }

    double numerator = derivative(f, x + h, order - 1, h) - derivative(f, x, order - 1, h);
    return numerator / h;
}

double taylorSeries(FunctionPointer f, double a, double x, int n) {
    double result = 0.0;
    for (int i = 0; i <= n; i++) {
        result += (derivative(f, a, i, 0.0001) / factorial(i)) * pow(x - a, i);
    }
    return result;
}

// Example functions
double exponentialFunction(double x) {
    return exp(x);
}

double sineFunction(double x) {
    return sin(x);
}

int main() {
    double a, x;
    int n;

    printf("Enter the point a: ");
    scanf("%lf", &a);

    printf("Enter the value of x: ");
    scanf("%lf", &x);

    printf("Enter the degree of the Taylor series (n): ");
    scanf("%d", &n);

    // Example 1: f(x) = e^x
    double resultExp = taylorSeries(exponentialFunction, a, x, n);
    printf("Taylor series expansion for e^x: %.6f\n", resultExp);

    // Example 2: f(x) = sin(x)
    double resultSin = taylorSeries(sineFunction, a, x, n);
    printf("Taylor series expansion for sin(x): %.6f\n", resultSin);

    return 0;
}
