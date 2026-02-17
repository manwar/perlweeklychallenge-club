#include "alloc.h"

IntArray* get_fibonacci(int n) {
    IntArray* fibs = intarray_new();

    intarray_push_back(fibs, 0);
    intarray_push_back(fibs, 1);

    while (true) {
        int next = fibs->data[fibs->size - 1] + fibs->data[fibs->size - 2];
        if (next > n)
            break;
        intarray_push_back(fibs, next);
    }

    return fibs;
}

IntArray* get_zeckendorf(int target) {
    IntArray* fibs = get_fibonacci(target);
    intarray_reverse(fibs);

    IntArray* result = intarray_new();
    int last_index = -2;
    for (int i = 0; i < fibs->size; i++) {
        int f = fibs->data[i];
        if (f <= target && f > 0 && i > last_index + 1) {
            intarray_push_back(result, f);
            target -= f;
            last_index = i;
            if (target == 0)
                break;
        }
    }

    intarray_free(fibs);
    return result;
}

int main(int argc, char* argv[]) {
    if (argc != 2)
        die("usage: %s n", argv[0]);

    IntArray* seq = get_zeckendorf(atoi(argv[1]));
    intarray_print(seq);
    intarray_free(seq);
}
