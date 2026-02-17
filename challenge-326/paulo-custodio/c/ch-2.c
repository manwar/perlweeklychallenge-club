#include "alloc.h"

IntArray* decompress(IntArray* pairs) {
    if (pairs->size % 2 != 0)
        die("list must be even");

    IntArray* output = intarray_new();

    for (int i = 0; i < pairs->size; i += 2) {
        int count = pairs->data[i];
        int num   = pairs->data[i + 1];
        for (int j = 0; j < count; j++) {
            intarray_push_back(output, num);
        }
    }
    return output;
}

int main(int argc, char* argv[]) {
    if (argc < 2 || (argc-1) % 2 != 0)
        die("usage: %s pairs...", argv[0]);

    argv++; argc--;
    IntArray* pairs = intarray_new();
    for (int i = 0; i < argc; i++)
        intarray_push_back(pairs, atoi(argv[i]));

    IntArray* decompressed = decompress(pairs);
    intarray_print(decompressed);

    intarray_free(pairs);
    intarray_free(decompressed);
}
