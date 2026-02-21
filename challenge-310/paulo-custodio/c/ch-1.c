#include "alloc.h"

IntArray* parse_list(const char* str_) {
    char* str = xstrdup(str_);
    IntArray* list = intarray_new();
    const char* separators = " \t\r\n,";
    char* p = strtok(str, separators);
    while (p != NULL) {
        intarray_push_back(list, atoi(p));
        p = strtok(NULL, separators);
    }
    xfree(str);
    return list;
}

IntArray* find_common(int argc, char* argv[]) {
    if (argc == 0)
        return intarray_new();
    // use first list as common
    IntArray* common = parse_list(argv[0]);

    // eliminate items that do not appear in the other lists
    for (int i = 1; i < argc; i++) {
        IntArray* other = parse_list(argv[i]);
        for (int j = 0; j < common->size; j++) {
            int found = intarray_find_index(other, common->data[j]);
            if (found < 0) {    // not common
                memmove(common->data+j, common->data+j+1, (common->size - (j+1)) * sizeof(int));
                common->size--;
                j--;
            }
        }
        intarray_free(other);
    }
    return common;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s 'n n n' 'n n n' ...", argv[0]);

    IntArray* common = find_common(argc-1, argv+1);
    intarray_print(common);
    intarray_free(common);
}
