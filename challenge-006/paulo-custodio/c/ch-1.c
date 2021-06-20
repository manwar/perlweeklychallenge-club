/*
Challenge 006

Challenge #1
Create a script which takes a list of numbers from command line and print the
same in the compact form. For example, if you pass "1,2,3,4,9,10,14,15,16"
then it should print the compact form like "1-4,9,10,14-16".
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* nums, nr_nums = 0;

void* check_mem(void* p) {
    if (!p) {
        fputs("Out of memory", stderr);
        exit(EXIT_FAILURE);
    }
    return p;
}

void parse_nums(char* str) {
    char* num_str = strtok(str, ",");
    while (num_str != NULL) {
        int num = atoi(num_str);
        nums = check_mem(realloc(nums, ++nr_nums * sizeof(int)));
        nums[nr_nums - 1] = num;

        num_str = strtok(NULL, ",");
    }
}

int main(int argc, char* argv[]) {
    if (argc != 2) return EXIT_FAILURE;
    parse_nums(argv[1]);
    for (int i = 0; i < nr_nums; i++) {
        printf("%d", nums[i]);
        if (i + 2 < nr_nums && 
            nums[i + 1] == nums[i] + 1 && 
            nums[i + 2] == nums[i] + 2) {
            int j = 0;
            while (i + j < nr_nums && nums[i + j] == nums[i] + j)
                j++;
            i += j - 1;
            printf("-%d", nums[i]);
        }
        if (i + 1 < nr_nums)
            printf(",");
    }
    printf("\n");
    free(nums);
}

