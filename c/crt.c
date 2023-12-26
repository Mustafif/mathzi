#include <stdio.h>

// Function to calculate the modular inverse using extended Euclidean algorithm
int modInverse(int a, int m) {
    int m0 = m, t, q;
    int x0 = 0, x1 = 1;

    if (m == 1)
        return 0;

    while (a > 1) {
        q = a / m;
        t = m;

        m = a % m, a = t;
        t = x0;

        x0 = x1 - q * x0;
        x1 = t;
    }

    if (x1 < 0)
        x1 += m0;

    return x1;
}

// Function to apply Chinese Remainder Theorem
int chineseRemainder(int numEquations, int *remainders, int *moduli) {
    int product = 1;
    for (int i = 0; i < numEquations; ++i) {
        product *= moduli[i];
    }

    int result = 0;
    for (int i = 0; i < numEquations; ++i) {
        int Mi = product / moduli[i];
        int Mi_inverse = modInverse(Mi, moduli[i]);

        result += (remainders[i] * Mi * Mi_inverse) % product;
        result %= product;
    }

    return result;
}

int main() {
    int numEquations = 3;
    int remainders[] = {2, 3, 2};
    int moduli[] = {3, 5, 7};

    int result = chineseRemainder(numEquations, remainders, moduli);

    printf("The solution is: %d\n", result);

    return 0;
}
