#include "alloc.h"
#include <ctype.h>

bool first_num = true;
int last_num = 0;
bool is_strictly_ascending = true;

void check_num(int n) {
    if (!first_num && n <= last_num) {
        is_strictly_ascending = false;
    }
    first_num = false;
    last_num = n;
}

void collect_nums(int argc, char* argv[]) {
    for (int i = 0; i < argc; i++) {
        if (isdigit(argv[i][0])) {
            int n = atoi(argv[i]);
            check_num(n);
        }
    }
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums/words...", argv[0]);

    argc--; argv++;
    collect_nums(argc, argv);
    printf("%s\n", is_strictly_ascending ? "true" : "false");
}
