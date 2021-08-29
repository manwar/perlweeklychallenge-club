#include <err.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <limits.h>

int main(int argc, char *argv[]) {
    if (argc != 2) {
        puts("Usage: ./ch-1 <number>");
        exit(0);
    }

    const char *errstr;
    int num = strtonum(argv[1], 1, INT_MAX, &errstr);
    if (errstr != NULL)
        errx(1, "number is %s: %s", errstr, argv[1]);

    for (int idx = 1; idx <= num; idx++) {
        bool take = true;

        int str_size = 1 + snprintf(NULL, 0, "%d", idx);
        char *num_str = calloc(str_size, sizeof(char));
        snprintf(num_str, str_size, "%d", idx);

        for (int x = 0; num_str[x] != '\0'; x++)
            if (num_str[x] == '1') take = false;
        free(num_str);

        if (take == true) printf("%d ", idx);
    }
    printf("\n");
}
