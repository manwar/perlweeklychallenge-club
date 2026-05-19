#include <stdio.h>

void proc(int len, int list[len], int n) {
  printf("Input: (");
  for (int i = 0; i < len - 1; i++)
    printf("%d, ", list[i]);
  printf("%d), n = %d\n", list[len-1], n);
  int k = len / n;
  int r = len % n;

  if (k == 0) {
    printf("Output: -1\n");
    return;
  }
  // produce n lists of length k (first list is length k + r)
  int a[n][k+r] = {};

  for (int i = 0; i < k; i++)
    a[0][i] = list[i];
  for (int i = 0; i < r; i++)
    a[0][k + i] = list[k + i];
  for (int j = 1; j < n; j++)
    for (int i = 0; i < k; i++)
      a[j][i] = list[j*k + i + r];

  
  printf("Output: (");
  for (int i = 0; i < k+r-1; i++)
    printf("%d, ", a[0][i]);
  printf("%d), ", a[0][k+r-1]);
  for (int j = 1; j < n-1; j++) {
    printf("(");
    for (int i = 0; i < k-1; i++)
      printf("%d, ", a[j][i]);
    printf("%d), ", a[j][k-1]);
  }
  printf("(");
  for (int i = 0; i < k-1; i++)
    printf("%d, ", a[n-1][i]);

  printf("%d)\n", a[n-1][k-1]);
}

int main() {
  int list[] = {1,2,3,4,5};
  int n = 2;
  proc(sizeof(list)/sizeof(int), list, n);
  int list2[] = {1,2,3,4,5,6};
  n = 3;
  proc(sizeof(list2)/sizeof(int), list2, n);
  int list3[] = {1,2,3};
  n = 2;
  proc(sizeof(list3)/sizeof(int), list3, n);
  int list4[] = {1,2,3,4,5,6,7,8,9,10};
  n = 5;
  proc(sizeof(list4)/sizeof(int), list4, n);
  int list5[] = {1,2,3};
  n = 4;
  proc(sizeof(list5)/sizeof(int), list5, n);
}
