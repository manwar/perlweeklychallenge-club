#include <stdio.h>
#include <stdlib.h>
#include <string.h>

const size_t min(const size_t a, const size_t b) {
    return a <= b ? a : b;
}

void switch_rev(char *s) {
    const size_t len = strlen(s);
    for (size_t i = 0; i < min(len/2+1, len); i++) {
        const size_t j = len-1-i;
        const char tmp = s[i];
        s[i] = s[j] == '0' ? '1' : '0';
        s[j] = tmp  == '0' ? '1' : '0';
    }
}

const char *S(const int n) {
    const size_t len = (1 << n) - 1;
    char *s = malloc(len);
    s[0] = '\0';

    for (int i = 1; i <= n; i++) {
        const size_t eos = (1 << (i-1)) - 1;
        strcpy(s+eos+1, s);
        s[eos] = '0';
        switch_rev(s+eos+1);
    }
    return s;
}

int main(int argc, char *argv[]) {
    const int n = atoi(argv[1]);
    puts(S(n));
    
    return 0;
}
