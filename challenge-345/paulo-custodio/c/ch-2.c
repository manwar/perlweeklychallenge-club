#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
	int* nums;
	int size;
} Ints;

void init_ints(Ints* ints) {
	ints->nums = NULL;
	ints->size = 0;
}

void free_ints(Ints* ints) {
	free(ints->nums);
}

void push_ints(Ints* ints, int n) {
	ints->size++;
	ints->nums = realloc(ints->nums, ints->size * sizeof(int));
	assert(ints->nums);
	ints->nums[ints->size-1] = n;
}

void unshift_ints(Ints* ints, int n) {
	push_ints(ints, 0);		// make space
	memmove(ints->nums+1, ints->nums, (ints->size-1)*sizeof(int));
	ints->nums[0] = n;
}

void last_visitor(const Ints* nums, Ints* ans) {
	Ints seen;
	init_ints(&seen);

	int x = 0;	// how many -1s in a row BEFORE this one
	for (int i = 0; i < nums->size; i++) {
		int n = nums->nums[i];
		if (n >= 0) {
			unshift_ints(&seen, n);
			x = 0;	// reset streak
        }
        else {
            // use current x
            if (x < seen.size) {
				push_ints(ans, seen.nums[x]);
            }
            else {
				push_ints(ans, -1);
            }
            x++;	// increment streak for next -1
        }
    }
	
	free_ints(&seen);
}

int main(int argc, char* argv[]) {
	if (argc < 2) {
		fprintf(stderr, "usage: %s nums...\n", argv[0]);
		return EXIT_FAILURE;
	}
	
	argv++; argc--;
	Ints nums;
	init_ints(&nums);
	for (int i = 0; i < argc; i++)
		push_ints(&nums, atoi(argv[i]));
	
	Ints ans;
	init_ints(&ans);
	last_visitor(&nums, &ans);
	
	const char* separator = "";
	for (int i = 0; i < ans.size; i++) {
		printf("%s%d", separator, ans.nums[i]);
		separator = ", ";
	}
	
	free_ints(&nums);
	free_ints(&ans);
}
