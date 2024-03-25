#include <stdio.h>

int main() {
  int ints[] = {3, 1, 2, 2, 2, 1, 3};
  int k = 2;
  int intslen = sizeof(ints)/sizeof(int);
  printf("Input: ints = { ");
  for (int i = 0; i < intslen; i++)
    printf("%d ", ints[i]);
  printf("}, k = %d\n", k);
  int cnt = 0;
  for (int i = 0; i < intslen - 1; i++) {
    for (int j = i + 1; j < intslen; j++) {
      if (ints[i] != ints[j])
	continue;
      if (i * j % k == 0)
	cnt++;
    }
  }
  printf("Output: %d\n", cnt);
}
