#include <stdio.h>
#include "vec.h"

void proc(int ints[], int N) {
  printf( "Input: ints = { " );
  for (int i = 0; i < N; i++)
    printf("%d ", ints[i]);
  printf("}\n");
  vec arr1; init_vec(&arr1);
  vec arr2; init_vec(&arr2);
  int cnt = 2;
  push(&arr1, ints[0]);
  push(&arr2, ints[1]);
  
  while (cnt < N) {
    int x = ints[cnt];
    cnt++;
    if (arr1.data[arr1.size-1] > arr2.data[arr2.size-1]) {
      push(&arr1, x);
    } else {
      push(&arr2, x);
    }
  } 
  printf("Output: arr1 = { ");
  for (int i = 0; i < arr1.size; i++)
    printf("%d ", arr1.data[i]);

  printf("} arr2 = { ");
  for (int i = 0; i < arr2.size; i++)
    printf("%d ", arr2.data[i]);
  printf("}\n");
  destroy_vec(&arr1);
  destroy_vec(&arr2);
}

int main() {
  int ints[] = {2, 1, 3, 4, 5};
  int ints2[] = {3,2,4};
  int ints3[] = {5, 4, 3, 8};
  proc(ints, sizeof(ints)/sizeof(int));
  proc(ints2, sizeof(ints2)/sizeof(int));
  proc(ints3, sizeof(ints3)/sizeof(int));
}

