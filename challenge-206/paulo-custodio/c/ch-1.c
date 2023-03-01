/*
Challenge 206

Task 1: Shortest Time
Submitted by: Mohammad S Anwar

You are given a list of time points, at least 2, in the 24-hour clock format HH:MM.

Write a script to find out the shortest time in minutes between any two time points.
Example 1

Input: @time = ("00:00", "23:55", "20:00")
Output: 5

Since the difference between "00:00" and "23:55" is the shortest (5 minutes).

Example 2

Input: @array = ("01:01", "00:50", "00:57")
Output: 4

Example 3

Input: @array = ("10:10", "09:30", "09:00", "09:55")
Output: 15
*/

#include <stdio.h>
#include <stdlib.h>

int minutes(const char* str) {
    int hours = 0, minutes = 0;
    if (sscanf(str, "%d:%d", &hours, &minutes) == 2)
        return hours*60+minutes;
    else
        return 0;
}

int compare(const void* a, const void* b) {
    return *(int*)a - *(int*)b;
}

int main(int argc, char* argv[]) {
    argv++; argc--;
    if (argc < 2) {
        fputs("Usage: ch-1 time...\n", stderr);
        return EXIT_FAILURE;
    }

    int num_items = argc+1;
    int* items = malloc(num_items * sizeof(int));
    for (int i = 0; i < num_items-1; i++)
        items[i] = minutes(argv[i]);
    qsort(items, num_items-1, sizeof(int), compare);
    items[num_items-1] = items[0] + 24*60;

    int min = items[num_items-1] - items[0];
    for (int i = 0; i < num_items-1; i++) {
        for (int j = i+1; j < num_items; j++) {
            int n = items[j] - items[i];
            if (n < min)
                min = n;
        }
    }

    printf("%d\n", min);
    free(items);

    return EXIT_SUCCESS;
}
