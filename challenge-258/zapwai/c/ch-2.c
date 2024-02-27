#include <stdio.h>

int binary_tally(int num) {
  int tally = 0;
  int bitlen = sizeof(num) * 8;
  for (int i = bitlen - 1; i >= 0; i--) {
    if (num & (1 << i))
      tally++;
  }
  return tally;
}

void proc(int k, int intlen, int ints[]) {
  printf("Input: { ");
  for (int i = 0; i < intlen; i++) {
    printf("%d ", ints[i]);
  }
  printf("}, k = %d\n", k);
	 
  int sum = 0;
  for (int i = 0; i < intlen; i++) {
    int tally = binary_tally(i);
    if (tally == k) {
      sum += ints[i];
    }
  }

  printf("Output: %d\n", sum);
}

int main() {
  int ints1[] = {2, 5, 9, 11, 3}; int k1 = 1;
  int ints2[] = {2, 5, 9, 11, 3}; int k2 = 2;
  int ints3[] = {2, 5, 9, 11, 3}; int k3 = 0;
  int l1 = sizeof(ints1) / sizeof(int);
  int l2 = sizeof(ints2) / sizeof(int);
  int l3 = sizeof(ints3) / sizeof(int);    
  proc(k1, l1, ints1);
  proc(k2, l2, ints2);
  proc(k3, l3, ints3);
}
