#include "alloc.h"

#define SIDES 4

bool place_stick(int side, int* sides, IntArray* sticks, int i) {
    if (i >= sticks->size)
        return true;    // placed all sticks

    // try each side
    for (int s = 0; s < SIDES; s++) {
        if (sides[s] + sticks->data[i] > side) // too large
            continue;

        // place this stick and try next
        sides[s] += sticks->data[i];
        if (place_stick(side, sides, sticks, i+1))
            return true;
        sides[s] -= sticks->data[i];
    }

    return false; // did not manage to place this sticl
}

bool can_make_square(IntArray* sticks) {
    if (sticks->size == 0)
        return false;

    // sort by largest
    intarray_sort(sticks);
    intarray_reverse(sticks);

    // get sum of sticks
    int sum = 0;
    for (int i = 0; i < sticks->size; i++) {
        sum += sticks->data[i];
    }

    // must use all sticks
    if (sum % 4 != 0)
        return false;

    int side = sum / 4;

    // if largest stick too long
    if (sticks->data[0] > side)
        return false;

    // try to place each stick
    int sides[SIDES] = {0};
    return place_stick(side, sides, sticks, 0);
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s siticks...", argv[0]);

    IntArray* sticks = intarray_new();
    for (int i = 1; i < argc; i++)
        intarray_push_back(sticks, atoi(argv[i]));

    bool ok = can_make_square(sticks);
    printf("%s\n", bool_to_string(ok));

    intarray_free(sticks);
}
