#include <stdio.h>

void fibonacci(int n) {
    long long a = 0, b = 1;
    printf("Fibonacci sequence (first %d numbers):\n", n);
    for (int i = 0; i < n; i++) {
        printf("%lld ", a);
        long long next = a + b;
        a = b;
        b = next;
    }
    printf("\n");
}

int main() {
    int n = 20;
    fibonacci(n);
    return 0;
}
