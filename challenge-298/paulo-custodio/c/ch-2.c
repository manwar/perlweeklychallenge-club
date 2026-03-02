#include "alloc.h"

typedef struct {
    int start;
    int end;
} Interval;

int get_right_interval_index(int count, Interval* intervals, int find_index) {
    int min_distance = INT_MAX;
    int min_index = -1;
    for (int i = 0; i < count; i++) {
        int distance = intervals[i].start - intervals[find_index].end;
        if (distance >= 0 && distance < min_distance) {
            min_distance = distance;
            min_index = i;
        }
    }
    return min_index;
}

IntArray* get_right_interval(int count, Interval* intervals) {
    IntArray* indexes = intarray_new();
    for (int i = 0; i < count; i++) {
        int index = get_right_interval_index(count, intervals, i);
        intarray_push_back(indexes, index);
    }
    return indexes;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s intervals...", argv[0]);

    argc--; argv++;
    Interval* intervals = xcalloc(argc, sizeof(Interval));
    for (int i = 0; i < argc; i++)
        sscanf(argv[i], "%d %d", &intervals[i].start, &intervals[i].end);

    IntArray* indexes = get_right_interval(argc, intervals);
    intarray_print(indexes);

    xfree(intervals);
    intarray_free(indexes);
}
