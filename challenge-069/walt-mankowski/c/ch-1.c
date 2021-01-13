#include <stdio.h>
#include <stdlib.h>
#include <string.h>

const size_t min(const size_t a, const size_t b) {
    return a <= b ? a : b;
}

int is_strobogrammatic(const long long n) {
    char s[20];
    sprintf(s, "%lld", n);
    const size_t len = strlen(s);
    for (size_t i = 0; i < min(len/2+1, len); i++) {
        const size_t j = len-1-i;
        switch (s[i]) {
        case '0':
            if (s[j] != '0')
                return 0;
            break;
        case '1':
            if (s[j] != '1')
                return 0;
            break;
        case '6':
            if (s[j] != '9')
                return 0;
            break;
        case '8':
            if (s[j] != '8')
                return 0;
            break;
        case '9':
            if (s[j] != '6')
                return 0;
            break;
        default:
            return 0;
        }
    }
    return 1;
}

int main(int argc, char *argv[]) {
    const long long A = atoll(argv[1]);
    const long long B = atoll(argv[2]);

    for (long long i = A; i <= B; i++)
        if (is_strobogrammatic(i))
            printf("%lld\n", i);

    return 0;
}
