// Perl Weekly Challenge 236 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-236/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

int find_first_unvisited(IntArray* nums, bool* visited) {
    for (int i = 0; i < nums->size; i++) {
        if (!visited[i])
            return i;
    }
    return -1;
}

void make_trip(int start, IntArray* nums, bool* visited) {
    int pos = start;
    do {
        visited[pos] = true;
        pos = nums->data[pos];
        if (pos < 0 || pos >= nums->size)
            die("invalid position %d", pos);
    } while (pos != start);
}

int count_loops(IntArray* nums) {
    bool* visited = xcalloc(nums->size, sizeof(bool));
    int count = 0;
    while (true) {
        int start = find_first_unvisited(nums, visited);
        if (start < 0)
            break;      // no more elements to visit
        make_trip(start, nums, visited);
        count++;
    }
    xfree(visited);
    return count;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums...", argv[0]);

    IntArray* nums = intarray_new();
    for (int i = 1; i < argc; i++)
        intarray_push_back(nums, atoi(argv[i]));

    int count = count_loops(nums);
    printf("%d\n", count);

    intarray_free(nums);
}
