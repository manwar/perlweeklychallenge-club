#include "alloc.h"

IntArray* decode_xor(IntArray* encoded, int initial) {
    IntArray* decoded = intarray_new();
    intarray_push_back(decoded, initial);
    for (int i = 0; i < encoded->size; i++)
        intarray_push_back(decoded, decoded->data[decoded->size-1] ^ encoded->data[i]);
    return decoded;
}

int main(int argc, char* argv[]) {
    if (argc != 3)
        die("usage: %s list initial", argv[0]);

    IntArray* encoded = intarray_parse_list(argv[1]);
    int initial = atoi(argv[2]);

    IntArray* decoded = decode_xor(encoded, initial);
    intarray_print(decoded);

    intarray_free(encoded);
    intarray_free(decoded);
}
