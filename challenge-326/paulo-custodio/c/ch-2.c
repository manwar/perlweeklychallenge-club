#include "alloc.h"
#include "utarray.h"

UT_array* decompress(UT_array* pairs) {
    if (utarray_len(pairs) % 2 != 0)
        die("list must be even");

    UT_array* output;
    utarray_new(output, &ut_int_icd);

    for (int i = 0; i < utarray_len(pairs); i += 2) {
        int count = *(int*)utarray_eltptr(pairs, i);
        int num = *(int*)utarray_eltptr(pairs, i + 1);
        for (int j = 0; j < count; j++) {
            utarray_push_back(output, &num);
        }
    }
    return output;
}

int main(int argc, char* argv[]) {
    if (argc < 2 || (argc-1) % 2 != 0)
        die("usage: %s pairs...", argv[0]);

    argv++; argc--;
    UT_array* pairs;
    utarray_new(pairs, &ut_int_icd);
    for (int i = 0; i < argc; i++) {
        int num = atoi(argv[i]);
        utarray_push_back(pairs, &num);
    }

    UT_array* decompressed = decompress(pairs);

    const char* separator = "";
    for (int i = 0; i < utarray_len(decompressed); i++) {
        printf("%s%d", separator, *(int*)utarray_eltptr(decompressed, i));
        separator = ", ";
    }
    printf("\n");
}
