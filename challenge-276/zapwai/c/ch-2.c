#include <stdio.h>
#define MAX_LENGTH 20

void proc(int ints[], int intslen) {
  printf("Input: { ");
  for (int i = 0; i < intslen; i++)
    printf("%d ", ints[i]);
  printf("} \n");
  int nums[MAX_LENGTH] = {};
  int freq[MAX_LENGTH] = {};
    for (int i = 0; i < MAX_LENGTH; i++)
    freq[i] = 1;
  int numslen = 0;
  for (int i = 0; i < intslen; i++) {
    int item = ints[i];
    int have = 0;
    for (int j = 0; j < MAX_LENGTH; j++) {
      if (nums[j] == item) {
	have++;
      }
    }
    if (have == 0) {
      nums[numslen++] = item;
    } else {
      freq[item] = have + 1;
    }
  }
  int mostfreq[MAX_LENGTH];

  int mostfreqlen = 0;
  int f = 0;
  for (int i = 0; i < MAX_LENGTH; i++) {
    int num = nums[i];
    if (freq[num] > f)
      f = freq[num];
  }

  for (int i = 0; i < numslen; i++) {
    int num = nums[i];
    if (freq[num] == f)
      mostfreq[mostfreqlen++] = num;
  }
  printf("Output: The most frequent, { ");
	 
  for (int i = 0; i < mostfreqlen; i++) 
    printf("%d ", mostfreq[i]);
  printf("}, have %d occurrences.\n", f);
}

int main() {
  int ints[] = {1, 2, 2, 4, 1, 5};
  proc(ints, sizeof(ints) / sizeof(int));
  int ints2[] = {1, 2, 3, 4, 5};
  proc(ints2, sizeof(ints2) / sizeof(int));
}

