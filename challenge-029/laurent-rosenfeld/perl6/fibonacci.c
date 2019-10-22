#include <stdio.h>
int fib (int a) {
    if (a == 0 || a == 1) {
        return 1;
    } else {
        return fib(a -1 ) + fib(a - 2);
    }
}
