#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int get_minutes(const char* str) {
    const char* colon = strchr(str, ':');
    if (colon == NULL) {
        fprintf(stderr, "invalid time %s, expected hh:mm\n", str);
        exit(EXIT_FAILURE);
    }
    int h = atoi(str);
    int m = atoi(colon+1);
    int min = 60*h+m;
    return min;
}

int get_num_ops(int min1, int min2) {
    static const int steps[] = {60, 15, 5, 1, 0};
    if (min2 < min1)
        min2 += get_minutes("24:00");
    int ops = 0;
    int i = 0;
    while (min1 < min2) {
        while (min1 + steps[i] <= min2) {
            min1 += steps[i];
            ops++;
        }
        i++;
        if (steps[i] == 0)
            return -1;  // should not be here
    }
    return ops;
}

int main(int argc, char* argv[]) {
    if (argc != 3) {
        fprintf(stderr, "usage: %s hh:mm hh:mm\n", argv[0]);
        return EXIT_FAILURE;
    }

    int t1 = get_minutes(argv[1]);
    int t2 = get_minutes(argv[2]);
    int num_ops = get_num_ops(t1, t2);
    printf("%d\n", num_ops);
}
