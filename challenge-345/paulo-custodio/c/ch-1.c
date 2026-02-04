#include <assert.h>
#include <stdio.h>
#include <stdlib.h>

int* find_peeks(int* nums, int nums_size) {
	int* peeks = NULL;
	int peeks_size = 0;
	
	for (int i = 1; i < nums_size-1; i++) {
		if (nums[i] > nums[i-1] && nums[i] > nums[i+1]) {
			// found peek
			peeks_size++;
			peeks = realloc(peeks, peeks_size * sizeof(int));
			assert(peeks);
			peeks[peeks_size-1] = i;
		}
	}
	
	// add terminator			
	peeks_size++;
	peeks = realloc(peeks, peeks_size * sizeof(int));
	assert(peeks);
	peeks[peeks_size-1] = -1;
	
	return peeks;
}

int main(int argc, char* argv[]) {
	if (argc < 2) {
		fprintf(stderr, "usage: %s nums...\n", argv[0]);
		return EXIT_FAILURE;
	}
	
	argv++; argc--;
	int* nums = malloc(argc * sizeof(int));
	assert(nums);
	for (int i = 0; i < argc; i++)
		nums[i] = atoi(argv[i]);
	
	int* peeks = find_peeks(nums, argc);
	
	if (peeks[0] < 0) {
		printf("0\n");
	}
	else {
		const char* separator = "";
		for (int i = 0; peeks[i] >= 0; i++) {
			printf("%s%d", separator, peeks[i]);
			separator = ", ";
		}
	}
	
	free(peeks);
	free(nums);
}

		
