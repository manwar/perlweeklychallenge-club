#include<stdio.h>
#include<stdlib.h>
#include<assert.h>

int *array_of_product(const int *arr, size_t sz)
{
  int i,j;
  int *result = malloc(sz * sizeof(int));
  assert(result && "Allocation failed!\n");
  
  for(i = 0; i < sz; i++)
  {
    int prod = 1;
    for(j = 0; j < sz; j++)
    {
      if(i != j)
      {
	prod *= arr[j];
	result[i] = prod;
      }
    }
  }
  
  return result;
}

int main(void)
{
  int arr[] = {5, 2, 1, 4, 3};
  int arr2[] = {2, 1, 4, 3};
  
  size_t n = 5;
  size_t n2 = 4;
  
  int *result = array_of_product(arr, n);
  int *result2 = array_of_product(arr2, n2);
  
  for(int i = 0; i < n; i++)
    printf("%d ", result[i]);
  printf("\n");

  for(int i = 0; i < n2; i++)
    printf("%d ", result2[i]);
  printf("\n");

  
  if(result)
    free(result);
  if(result2)
    free(result2);
  
  return 0;
}
