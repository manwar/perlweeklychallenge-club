#include <stdio.h>
#include <string.h>

int main() {
    const char tests[2][10] = {
            { 3, 1, 4, 2, 3, 5 },
            { 4, 9, 0, 6, 2, 3, 8, 5 }
        };
    for (int j = 0; j <=1; j++) {
        char test[10];
        memcpy(test, tests[j],  sizeof(tests[j]));
        int i = test[0];
        printf("i = %d; nums = ", i);
        /* printing input test array */
        for (char k = 1; k < sizeof(test); k++) {
            printf("%d ", test[k]);
        }
        printf("  =>  ");
        /* printing the result */
        for (char k = 1; k < sizeof(test); k++) {
            if (test[k] > i) {
                printf("%d ", test[k]);
            }
        }
        printf("%s\n", "");
    }
}
