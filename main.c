#include <stdio.h>

static int A[1000000];
static int B[1000000];

int main(int argc, char** argv) {
    int n, i, j, t, min;
    scanf("%d", &n);
    min = 2147483647;
    for (i = 0; i < n; ++i) {
        scanf("%d", &t);
        A[i] = t;
        B[i] = t;
        if (t < min) {
            j = i;
            min = t;
        }
    }
    t = B[j];
    B[j] = B[0];
    B[0] = t;
    for (i = 0; i < n; ++i) {
        printf("%d ", B[i]);
    }

    return 0;
}
