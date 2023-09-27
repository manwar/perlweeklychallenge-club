#include<stdio.h>

int exact_change(int *arr,size_t sz)
{
  int fives = 0,tens = 0,twenties = 0;
  for(size_t i = 0; i < sz; ++i)
  {
    if(arr[i] == 10) if(!--fives) return 0;
    else if(arr[i] == 20)
    {
      if(fives && tens)
      {
	fives--;
	tens--;
      }
      else if(fives > 2) fives -= 3;
      else return 0;
    }
    switch(arr[i])
    {
    case 5:
      fives++;
      break;
    case 10:
      tens++;	
      break;
    case 20:
      twenties++;
      break;
    default:
      fprintf(stderr,"Only 5,10,20 allowed!");
      return 0;
    }
  }
  return 1;
}

int main(void)
{
  int arr1[] = {5,5,5,10,20};
  int arr2[] = {5,5,10,10,20};
  int arr3[] = {5,5,5,20};
  size_t sz1 = 5,sz2 = 5, sz3 = 4;
  printf("%d\n",exact_change(arr1,sz1));
  printf("%d\n",exact_change(arr2,sz2));
  printf("%d\n",exact_change(arr3,sz3));
  return 0;
}

