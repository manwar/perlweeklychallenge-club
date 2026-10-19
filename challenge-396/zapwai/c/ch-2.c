#include <stdio.h>
#include <stdbool.h>

bool trionic(int p, int q, int m, int arr[m]) {
  for (int i = 0; i < p; i++)
    if (arr[i] >= arr[i+1])
      return false;
  for (int i = p; i < q; i++)
    if (arr[i] <= arr[i+1])
      return false;
  for (int i = q; i < m - 1; i++)
    if (arr[i] >= arr[i+1])
      return false;
  return true;
}

void proc(int m, int arr[m]) {
  printf("Input: ");
  for (int i = 0; i < m; i++)
    printf("%d ", arr[i]);
  printf("\n");
  char *out = "false";
  for (int p = 1; p < m - 2; p++) {
    for (int q = p + 1; q < m - 1; q++) {
      if (trionic(p, q, m, arr))
	out = "true";
    }
  }
  printf("Output: %s\n", out);
}

int main() {
  int arr[] = {1, 3, 5, 4, 2, 6, 8};
  proc(sizeof(arr)/sizeof(int), arr);
  int arr2[] = {1, 4, 4, 2, 1, 3, 5};
  proc(sizeof(arr2)/sizeof(int), arr2);
  int arr3[] = {2, 10, 3, 1, 9};
  proc(sizeof(arr3)/sizeof(int), arr3);
  int arr4[] = {1, 2, 3, 4, 3, 2, 1};
  proc(sizeof(arr4)/sizeof(int), arr4);
  int arr5[] = {1, 3, 6, 4, 2, 7, 8, 4};
  proc(sizeof(arr5)/sizeof(int), arr5);
}
