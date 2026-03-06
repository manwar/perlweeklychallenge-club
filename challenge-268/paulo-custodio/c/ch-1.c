#include "alloc.h"

StrArray* split(const char* str_, const char* separators) {
    char* str = xstrdup(str_);
    StrArray* words = strarray_new();
    char* p = strtok(str, separators);
    while (p != NULL) {
        strarray_push_back(words, p);
        p = strtok(NULL, separators);
    }
    xfree(str);
    return words;
}

IntArray* split_ints(const char* str) {
    StrArray* items = split(str, " ");
    IntArray* nums = intarray_new();
    for (int i = 0; i < items->size; i++)
        intarray_push_back(nums, atoi(items->data[i]));
    strarray_free(items);
    return nums;
}

int get_magic_number(IntArray* list1, IntArray* list2) {
    if (list1->size != list2->size)
        return -1;
    if (list1->size == 0)
        return 0;

    intarray_sort(list1);
    intarray_sort(list2);
    int delta = list2->data[0] - list1->data[0];

    for (int i = 1; i < list1->size; i++) {
        if (list2->data[i] - list1->data[i] != delta)
            return -1;
    }

    return delta;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s list1,list2", argv[0]);

    // get args
    Str* args = str_new();
    for (int i = 1; i < argc; i++)
        str_printf(args, "%s ", argv[i]);

    // get item lists
    StrArray* lists = split(args->body, ",");
    if (lists->size != 2)
        die("invalid input: %s", args->body);

    IntArray* list1 = split_ints(lists->data[0]);
    IntArray* list2 = split_ints(lists->data[1]);

    int magic = get_magic_number(list1, list2);
    printf("%d\n", magic);

    str_free(args);
    strarray_free(lists);
    intarray_free(list1);
    intarray_free(list2);
}
