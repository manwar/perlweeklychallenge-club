#include <stdio.h>
#include <stdlib.h>
int cmp (const void * a, const void * b){
  if (* (int *) a < *(int *)b) {return -1;}
  else if (*(int *)a > *(int *)b) {return 1;}
  else {return 0;}
}
int main() {
  int ints1[] = {1, 1, 4, 2, 1, 3};
  int ints2[] = {5, 1, 2, 3, 4};
  int ints3[] = {1, 2, 3, 4, 5};
  int *arrays[] = {ints1, ints2, ints3};
  int lengths[] = {6, 5, 5};
  int numA = 3;
  for (int j = 0; j < numA; j++) {
    int *ints = arrays[j];
    int length = lengths[j];
    int orig[length];
    for (int i = 0; i < length; i++){
      orig[i] = ints[i];
    }
    qsort(ints, length, sizeof(int), cmp);
    printf(" Input: ");  
    for (int i = 0; i < length; i++) {
      printf("%d ",orig[i]);
    }
    printf("\nSorted: ");    
    int cnt = 0;  
    for (int i = 0; i < length; i++) {
      printf("%d ",ints[i]);
      if (ints[i] == orig[i]) { cnt++; }
    }
    printf("\n");
    printf("Output: %d\n",cnt);
  }
}
