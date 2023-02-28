/*
Challenge 206

Task 2: Array Pairings
Submitted by: Mohammad S Anwar

You are given an array of integers having even number of elements..

Write a script to find the maximum sum of the minimum of each pairs.
Example 1

Input: @array = (1,2,3,4)
Output: 4

Possible Pairings are as below:
a) (1,2) and (3,4). So min(1,2) + min(3,4) => 1 + 3 => 4
b) (1,3) and (2,4). So min(1,3) + min(2,4) => 1 + 2 => 3
c) (1,4) and (2,3). So min(1,4) + min(2,3) => 2 + 1 => 3

So the maxium sum is 4.

Example 2

Input: @array = (0,2,1,3)
Output: 2

Possible Pairings are as below:
a) (0,2) and (1,3). So min(0,2) + min(1,3) => 0 + 1 => 1
b) (0,1) and (2,3). So min(0,1) + min(2,3) => 0 + 2 => 2
c) (0,3) and (2,1). So min(0,3) + min(2,1) => 0 + 1 => 1

So the maximum sum is 2.
*/

#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MIN(a,b) ((a) < (b) ? (a) : (b))
#define MAX(a,b) ((a) > (b) ? (a) : (b))

typedef struct {
	size_t count;
	int* items;
} IList;

IList* ilist_new(size_t count) {
	IList* list = calloc(1, sizeof(IList));
	assert(list);
	if (count) {
		list->count = count;
		list->items = calloc(count, sizeof(int));
		assert(list->items);
	}
	return list;
}

void ilist_free(IList* list) {
	free(list->items);
	free(list);
}

void ilist_push(IList* list, int elem) {
	list->count++;
	list->items = realloc(list->items, list->count * sizeof(int));
	assert(list->items);
	list->items[list->count - 1] = elem;
}

void ilist_remove(IList* list, size_t index) {
	assert(index < list->count);
	memmove(&list->items[index], &list->items[index+1], (list->count - (index+1))*sizeof(int));
	list->count--;
}

IList* ilist_clone(IList* list) {
	IList* copy = ilist_new(list->count);
	assert(copy);
	memcpy(copy->items, list->items, list->count * sizeof(int));
	return copy;
}

void compute_pairs_max(int* max, IList* set, IList* pending) {
	if (pending->count == 0) {		// compute sum, set max
		int sum = 0;
		for (int i = 0; i < set->count; i += 2) {
			int n = MIN(set->items[i], set->items[i + 1]);
			sum += n;
		}
		*max = MAX(*max, sum);
	}
	else {							// recurse for each pair
		for (int i = 0; i < pending->count - 1; i++) {
			for (int j = i+1; j < pending->count; j++) {
				IList* new_set = ilist_clone(set);
				IList* new_pending = ilist_clone(pending);

				ilist_push(new_set, pending->items[i]);
				ilist_push(new_set, pending->items[j]);

				ilist_remove(new_pending, j);
				ilist_remove(new_pending, i);

				compute_pairs_max(max, new_set, new_pending);

				ilist_free(new_set);
				ilist_free(new_pending);
			}
		}
	}
}

int main(int argc, char* argv[]) {
	argv++; argc--;
	if (argc % 2 != 0) {
		fputs("usage: ch-2 pairs...\n", stderr);
		return EXIT_FAILURE;
	}

	IList* set = ilist_new(0);
	IList* pending = ilist_new(argc);
	for (int i = 0; i < argc; i++)
		pending->items[i] = atoi(argv[i]);

	int max = 0;
	compute_pairs_max(&max, set, pending);
	printf("%d\n", max);

	ilist_free(set);
	ilist_free(pending);

	return EXIT_SUCCESS;
}
