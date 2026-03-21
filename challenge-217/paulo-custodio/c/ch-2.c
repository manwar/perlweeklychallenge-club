// Perl Weekly Challenge 217 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-217/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

int compare(const void* a_, const void* b_) {
    char a_str[32]; int a = *(int*)a_; sprintf(a_str, "%d", a);
    char b_str[32]; int b = *(int*)b_; sprintf(b_str, "%d", b);

    if (a_str[0] != b_str[0])
        return b_str[0] - a_str[0];
    else
        return strlen(a_str) - strlen(b_str);
}

Str* largest_number(IntArray* nums) {
    qsort(nums->data, nums->size, sizeof(int), compare);
    Str* text = str_new();
    for (int i = 0; i < nums->size; i++)
        str_printf(text, "%d", nums->data[i]);
    return text;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums...", argv[0]);

    IntArray* nums = intarray_new();
    for (int i = 1; i < argc; i++)
        intarray_push_back(nums, atoi(argv[i]));

    Str* text = largest_number(nums);
    printf("%s\n", text->body);

    intarray_free(nums);
    str_free(text);
}
