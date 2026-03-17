#include "../../../challenge-001/paulo-custodio/c/alloc.h"

void parse_list(IntArray* list, char* text) {
    char* p = strtok(text, " ");
    while (p != NULL) {
        intarray_push_back(list, atoi(p));
        p = strtok(NULL, " ");
    }
}

void parse_lists(int argc, char* argv[], IntArray* list1, IntArray* list2) {
    // collect all args
    Str* args = str_new();
    for (int i = 0; i < argc; i++)
        str_printf(args, "%s ", argv[i]);

    // split by comma
    char* p1 = strtok(args->body, ",");
    if (p1 == NULL)
        die("empty input");

    char* p2 = strtok(NULL, ",");
    if (p2 == NULL)
        die("missing comma in input");

    parse_list(list1, p1);
    parse_list(list2, p2);
}

IntArray* relative_sort(IntArray* list1, IntArray* list2) {
    IntArray* output = intarray_new();
    for (int i = 0; i < list2->size; i++) {
        int n = list2->data[i];
        int index;
        while ((index = intarray_find_index(list1, n)) >= 0) {
            intarray_push_back(output, n);
            intarray_erase(list1, index);
        }
    }
    intarray_sort(list1);   // sort remaing items
    for (int i = 0; i < list1->size; i++) {
        intarray_push_back(output, list1->data[i]);
    }
    return output;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums, nums...", argv[0]);

    IntArray* list1 = intarray_new();
    IntArray* list2 = intarray_new();

    parse_lists(argc-1, argv+1, list1, list2);
    IntArray* output = relative_sort(list1, list2);

    intarray_print(output);

    intarray_free(list1);
    intarray_free(list2);
    intarray_free(output);
}
