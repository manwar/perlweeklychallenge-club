#include "alloc.h"

typedef struct {
    int num;
    int count;
} Freq;

Freq* freq = NULL;
int freq_size = 0;

void count_num(int num) {
    for (int i = 0; i < freq_size; i++) {
        if (freq[i].num == num) {
            freq[i].count++;
            return;
        }
    }

    freq_size++;
    freq = xrealloc(freq, freq_size * sizeof(Freq));
    freq[freq_size-1].num = num;
    freq[freq_size-1].count = 1;
}

int gcd(int a, int b) {
    while (b != 0) {
        int temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}

bool can_make_equal_groups(int* nums, int size) {
    if (size < 2)
        return false;

    // count occurences of each number
    for (int i = 0; i < size; i++)
        count_num(nums[i]);

    // find GCD of all counts
    int res = freq[0].count;
    for (int i = 1; i < freq_size; i++) {
        res = gcd(res, freq[i].count);
        if (res == 1)
            break;      // no split posssible
    }

    // return true if GCD is at least 2
    return res >= 2;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums...", argv[0]);

    argc--; argv++;
    int* nums = xmalloc(argc * sizeof(int));
    for (int i = 0; i < argc; i++)
        nums[i] = atoi(argv[i]);
    bool ok = can_make_equal_groups(nums, argc);
    printf("%s\n", ok ? "true" : "false");
    xfree(nums);
    xfree(freq);
}
