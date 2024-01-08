#include <stdio.h>
#include <stdlib.h>
void proc(int*, int);
int main() {
  int arr0[] = {6, 12, 25, 1};
  int arr1[] = {10, 7, 31, 5, 2, 2};  
  int arr2[] = {1,2,10};
  int L[3] = {sizeof(arr0)/sizeof(int),
	      sizeof(arr1)/sizeof(int),
	      sizeof(arr2)/sizeof(int),
  };
  printf("\n");
  proc(arr0, L[0]);
  printf("\t-=-=-\n");
  proc(arr1, L[1]);
  printf("\t-=-=-\n");  
  proc(arr2, L[2]);    
  printf("\n");
}

void proc(int* arr, int L) {
  int sum = 0;
  int k = 0;
  if (L % 2 == 1) {
    k = L/2;
    sum += arr[k];
  } else {
    k = L/2 - 1;
  }

  for (int i = 0; i <= k; i++) {
    int a;
    if (L % 2 == 1) {
      if (i == k) {
	break;
      }
      a = arr[k-i-1];
    } else {
      a = arr[k-i];
    }
    int b = arr[k+1+i];
    char x[20];
    sprintf(x, "%d%d", a,b);
    int X = atoi(x);
    //    printf("%d\n",X);
    sum += X;
  }
  printf("Input: arr = {");
  for (int i = 0; i < L - 1; i++) {
    printf("%d, ",arr[i]);
  }
  printf("%d}\n",arr[L-1]);
  printf("Output: %d\n",sum);
}
