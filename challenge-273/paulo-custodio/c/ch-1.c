#include "../../../challenge-001/paulo-custodio/c/alloc.h"

int percentage_char(const char* str, char ch) {
    int count_ch = 0;
    int len = strlen(str);

    for (const char* p = str; *p; p++) {
        if (*p == ch)
            count_ch++;
    }

    // round to the nearest integer
    return (count_ch * 100 + len / 2) / len;
}

int main(int argc, char* argv[]) {
    if (argc != 3)
        die("usage: %s string char", argv[0]);

    int percent = percentage_char(argv[1], argv[2][0]);
    printf("%d\n", percent);
}
