#include "alloc.h"

StrArray* parse_list(const char* str_) {
    char* str = xstrdup(str_);
    StrArray* list = strarray_new();
    const char* separators = " \t,.";
    char* p = strtok(str, separators);
    while (p != NULL) {
        strarray_push_back(list, p);
        p = strtok(NULL, separators);
    }
    xfree(str);
    return list;
}

int count_common(StrArray* list1, StrArray* list2) {
    int common = 0;
    for (int i = 0; i < list1->size; i++) {
        int found = strarray_find_index(list2, list1->data[i]);
        if (found >= 0)
            common++;
    }
    return common;
}

int main(int argc, char* argv[]) {
    if (argc != 3)
        die("usage: %s list1 list2", argv[0]);

    StrArray* list1 = parse_list(argv[1]);
    StrArray* list2 = parse_list(argv[2]);
    int common = count_common(list1, list2);
    printf("%d\n", common);
    strarray_free(list1);
    strarray_free(list2);
}
