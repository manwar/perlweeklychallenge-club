#include <stdio.h>
#include <stdlib.h>

void proc(int m, int a[m]) {
  printf("Input: ");
  for (int i = 0; i < m; i++)
    printf("%d ", a[i]);
  printf("\n");
  int *e = malloc(m);
  int elen = 0;
  for (int i = 0; i < m; i++)
    if (a[i] % 6 == 0)
      e[elen++] = a[i];
  
  float avg = 0;
  for (int i = 0; i < elen; i++)
    avg += e[i];

  int o = 0;
  
  if (elen > 0) {
    avg /= elen;
    int b = (int) avg;
    o = ((avg - b) < 0.5) ? b : b + 1;
  } else {
    o = 0;
  }
  printf("Output: %d\n", o);
  free(e);
}

int main() {
  int arr[] ={18,5,7,11};
  proc(sizeof(arr)/sizeof(int), arr);
  int arr2[] = {6, 12, 18, 24, 30, 40};
  proc(sizeof(arr2)/sizeof(int), arr2);
  int arr3[] = {3, 9, 15, 21, 27};
  proc(sizeof(arr3)/sizeof(int), arr3);
  int arr4[] = {6, 12, 14, 20};
  proc(sizeof(arr4)/sizeof(int), arr4);
  int arr5[] = {6, 6, 6, 12, 12};
  proc(sizeof(arr5)/sizeof(int), arr5);
}
