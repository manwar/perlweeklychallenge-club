#include "alloc.h"

Str* group_digit_sum(const char* input, int n) {
    Str* s1 = str_new();
    Str* s2 = str_new();

    str_append(s1, input);
    while (s1->size > n) {
        // compute sum of digit groups, append to s2
        str_clear(s2);
        for (int start = 0; start < s1->size; start += n) {
            int sum = 0;
            for (int i = start; i < s1->size && i < start + n; i++) {
                sum += s1->body[i] - '0';
            }
            str_printf(s2, "%d", sum);
        }
        // swap s1 and s2
        Str* t = s1; s1 = s2; s2 = t;
    }

    str_free(s2);
    return s1;
}

int main(int argc, char* argv[]) {
    if (argc != 3)
        die("usage: %s digits n", argv[0]);

    Str* group = group_digit_sum(argv[1], atoi(argv[2]));
    printf("%s\n", group->body);
    str_free(group);
}
