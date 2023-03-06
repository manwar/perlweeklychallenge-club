/*
Challenge 205

Task 2: Maximum XOR
Submitted by: Mohammad S Anwar

You are given an array of integers.

Write a script to find the highest value obtained by XORing any two distinct members of the array.
Example 1

Input: @array = (1,2,3,4,5,6,7)
Output: 7

The maximum result of 1 xor 6 = 7.

Example 2

Input: @array = (2,4,1,3)
Output: 7

The maximum result of 4 xor 3 = 7.

Example 3

Input: @array = (10,5,7,12,8)
Output: 15

The maximum result of 10 xor 5 = 15.
*/

#include <stdio.h>
#include <stdlib.h>

int main(int argc, char* argv[]) {
    argv++; argc--;
    int result = -1;

    if (argc > 0) {
        int num_items = argc;
        int* items = malloc(num_items * sizeof(int));

        // parse input numbers
        for (int i = 0; i < num_items; i++)
            items[i] = atoi(argv[i]);

        // compute max of xor of all pairs
        for (int i = 0; i < num_items-1; i++) {
            for (int j = i+1; j < num_items; j++) {
                int n = items[i] ^ items[j];
                if (n > result)
                    result = n;
            }
        }

        free(items);
    }

    printf("%d\n", result);
    return EXIT_SUCCESS;
}
