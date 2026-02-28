#include "alloc.h"

void find_next_permutation(IntArray* nums) {
    // Find the longest not increasing suffix
    int pivot = -1;
    for (int i = nums->size-2; i >= 0; i--) {
        if (nums->data[i] < nums->data[i+1]) {
            pivot = i;
            break;
        }
    }

    // check if not found, sequence was lasy one
    if (pivot < 0)
        return;

    // find the rightmost successor to the pivot
    int successor = -1;
    for (int i = nums->size-1; i >= 0; i--) {
        if (nums->data[i] > nums->data[pivot]) {
            successor = i;
            break;
        }
    }

    // swap the pivot with the successor
    int temp = nums->data[pivot];
    nums->data[pivot] = nums->data[successor];
    nums->data[successor] = temp;

    // reverse suffix
    int bot = pivot+1;
    int top = nums->size-1;
    while (bot < top) {
        temp = nums->data[top];
        nums->data[top] = nums->data[bot];
        nums->data[bot] = temp;
        bot++;
        top--;
    }
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums...", argv[0]);

    IntArray* nums = intarray_new();
    for (int i = 1; i < argc; i++)
        intarray_push_back(nums, atoi(argv[i]));

    find_next_permutation(nums);
    intarray_print(nums);

    intarray_free(nums);
}
