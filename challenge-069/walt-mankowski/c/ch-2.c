#include <stdio.h>
#include <stdlib.h>
#include <string.h>

const size_t min(const size_t a, const size_t b) {
    return a <= b ? a : b;
}

char *rev(const char *s) {
    const size_t len = strlen(s);
    char *t = malloc(len+1);
    strcpy(t, s);
    for (size_t i = 0; i < min(len/2+1, len); i++) {
        const size_t j = len-1-i;
        char tmp = t[i];
        t[i] = t[j];
        t[j] = tmp;
    }

    return t;
}

char *swtch(char *s) {
    for (size_t i = 0; i < strlen(s); i++)
        if (s[i] == '0')
            s[i] = '1';
        else
            s[i] = '0';

    return s;
}

char *S(const int n) {
    const size_t len = (1 << n) - 1;
    char *s = malloc(len);
    s[0] = '\0';

    for (int i = 1; i <= n; i++) {
        char *rs = swtch(rev(s));
        const size_t eos = (1 << (i-1)) - 1;
        s[eos] = '0';
        strcat(s+eos+1, rs);
        free(rs);
    }
    return s;
}

int main(int argc, char *argv[]) {
    const int n = atoi(argv[1]);
    puts(S(n));
    
    return 0;
}
