#include <stdio.h>
#include <stdbool.h>

bool is_in(int val, int m, int a[m]) {
  for (int i = 0; i < m; i++)
    if (val == a[i]) return true;
  return false;
}

int next_int(float v) {
  if (v < 1)
    return 1;
  return (int) (v + 1);
}

float avg(int m, int a[m]) {
  int sum = 0;
  for (int i = 0; i < m; i++)
    sum += a[i];
  float ans = (float) sum / (float) m;
  return ans; 
}

void proc(int m, int a[m]) {
  printf("Input: ");
  for (int i = 0; i < m; i++)
    printf("%d ", a[i]);
  printf("\n");
  float average = avg(m, a);
  int next = next_int(average);
  while (is_in(next, m, a)) {
    next = next_int(next);
  }
  printf("Output: %d\n", next);
}

int main() {
  int a[] = {1,2,4,5,6};
  proc(sizeof(a)/sizeof(int), a);
  int a2[] = {-5, -2, -1, 3};
  proc(sizeof(a2)/sizeof(int), a2);
  int a3[] = {1,2,3};
  proc(sizeof(a3)/sizeof(int), a3);
  int a4[] = {2,3,7,8};
  proc(sizeof(a4)/sizeof(int), a4);
  int a5[] = {1,1,1,10};
  proc(sizeof(a5)/sizeof(int), a5);
}
