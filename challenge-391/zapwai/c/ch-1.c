#include <stdio.h>
#include <stdlib.h>

int comp(const void *a, const void *b) {
  int x = *(const int *)a;
  int y = *(const int *)b;
  if (x < y) {
    return -1;
  }
  if (x > y) {
    return 1;
  }
  return 0;
}

void proc(int m1, int arr1[m1], int m2, int arr2[m2]) {
  printf("Input: ");
  printf("\tarr1 = {");
  for (int i = 0; i < m1 - 1; i++)
    printf("%d ", arr1[i]);
  if (m1 - 1 >= 0)
    printf("%d", arr1[m1-1]);
  printf("}\n");
  printf("\tarr2 = {");
  for (int i = 0; i < m2 - 1; i++)
    printf("%d ",arr2[i] );
  if (m2 - 1 >= 0)
    printf("%d", arr2[m2-1]);
  printf("}\n");
  
  int a[m1 + m2] = {};
  for (int i = 0; i < m1; i++)
    a[i] = arr1[i];
  for (int i = 0; i < m2; i++)
    a[i+m1] = arr2[i];
  qsort(a, sizeof(a)/sizeof(a[0]), sizeof(a[0]), comp);
  
  float output;
  if ((m1 + m2) % 2 == 0) {
    int ind = (m1 + m2) / 2;
    int x = a[ind];
    int y = a[ind-1];
    output = (x+y) / 2.0;
  } else {
    int ind = (m1 + m2 - 1) / 2;
    output = a[ind];
  }
  printf("Output: %.2f\n", output);
}

int main() {
  int arr1[] = {2};
  int arr2[] = {4};
  int m1 = sizeof(arr1) / sizeof(int);
  int m2 = sizeof(arr2) / sizeof(int);
  proc(m1, arr1, m2, arr2);

  int arra1[] = {1,2,3};
  int arra2[] = {7,8,9,10};
  m1 = sizeof(arra1) / sizeof(int);
  m2 = sizeof(arra2) / sizeof(int);
  proc(m1, arra1, m2, arra2);
  
  int arrb1[] = {};
  int arrb2[] = {10,20,30,40};
  m1 = sizeof(arrb1) / sizeof(int);
  m2 = sizeof(arrb2) / sizeof(int);
  proc(m1, arrb1, m2, arrb2);

  int arrc1[] = {100};
  int arrc2[] = {1,2,3,4,5,6,7};
  m1 = sizeof(arrc1) / sizeof(int);
  m2 = sizeof(arrc2) / sizeof(int);
  proc(m1, arrc1, m2, arrc2);

  int arrd1[] = {1,2,2};
  int arrd2[] = {2,2,3};
  m1 = sizeof(arrd1) / sizeof(int);
  m2 = sizeof(arrd2) / sizeof(int);
  proc(m1, arrd1, m2, arrd2);
}
