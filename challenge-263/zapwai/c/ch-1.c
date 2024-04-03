#include <stdio.h>
#define MAX 300

void sort_me(int* ints, int intlen) {
  int cnt = 0;
  do {
    cnt = 0;
    for (int i = 0; i < intlen - 1; i++) {
      if (ints[i] > ints[i+1]) {
	cnt++;
	int tmp = ints[i];
	ints[i] = ints[i+1];
	ints[i+1] = tmp;
      }
    }
  } while (cnt != 0);
}

void proc(int k, int intlen, int ints[]) {
  printf("Input: ");
  for (int i = 0; i < intlen; i++)
    printf("%d ", ints[i]);
  printf("\n");

  sort_me(ints, intlen);
   
  int ind[MAX] = {};
  int j = 0;
  for (int i = 0; i < intlen; i++)
    if (ints[i] == k) {
      ind[j] = i;
      j++;
    }
  printf("Output: ");
  for (int i = 0; i < j; i++)
    printf("%d ", ind[i]);
  printf("\n");
}

int main() {
  int ints1[] = {1, 5, 3, 2, 4, 2}; int k1 = 2;
  int ints2[] = {1, 2, 4, 3, 5}; int k2 = 6;
  int ints3[] = {5, 3, 2, 4, 2, 1}; int k3 = 4;
  int intlen1 = sizeof(ints1) / sizeof(int);
  int intlen2 = sizeof(ints2) / sizeof(int);
  int intlen3 = sizeof(ints3) / sizeof(int);
  proc(k1, intlen1, ints1);
  proc(k2, intlen2, ints2);
  proc(k3, intlen3, ints3);
}
