#include <stdio.h>

void proc(int m, int a[m]) {
  printf("Input: a = {");
  for (int i = 0; i < m-1; i++)
    printf("%d, ", a[i]);
  printf("%d}\n", a[m-1]);
  
  int min = a[0], max = a[0];
  for (int i = 0; i < m; i++) {
    int val = a[i];
    if (min > val) min = val;
    if (max < val) max = val;
  }
  
  int cnt = 0;
  for (int i = 0; i < m; i++) {
    int val = a[i];
    if (val != min && val != max) cnt++;
    }
  printf("Output: %d\n", cnt);
}

int main() {
  int a[2] = {2,4};
  proc(2, a);

  int b[4] = {1,1,1,1};
  proc(4, b);

  int c[6] = {1, 1, 4, 8, 12, 12};
  proc(6, c);

  int d[4] = {3,6,6,9};
  proc(4, d);

  int e[5] = {0, -5, 10, -2, 4};
  proc(5, e);
}
