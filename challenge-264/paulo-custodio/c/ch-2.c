#include "../../../challenge-001/paulo-custodio/c/alloc.h"

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

IntArray* make_target(IntArray* source, IntArray* index) {
    IntArray* output = intarray_new();
    for (int i = 0; i < source->size; i++) {
        int n = source->data[i];
        int x = index->data[i];

        // insert n at x
        if (x >= output->size) {
            intarray_push_back(output, n);
        }
        else {
            int old_size = output->size;
            intarray_resize(output, old_size + 1);
            memmove(&output->data[x+1], &output->data[x], (old_size - x) * sizeof(int));
            output->data[x] = n;
        }
    }
    return output;
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

    IntArray* source = split_ints(lists->data[0]);
    IntArray* index = split_ints(lists->data[1]);
    if (source->size != index->size)
        die("invalid input: %s", args->body);

    IntArray* result = make_target(source, index);
    intarray_print(result);

    str_free(args);
    strarray_free(lists);
    intarray_free(source);
    intarray_free(index);
    intarray_free(result);
}
