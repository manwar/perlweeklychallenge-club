#include<stdio.h>

void separate_digits(int *arr,size_t sz)
{
  char temp[10] = {0};
  for(size_t i = 0; i < sz; ++i)
  {
    if(arr[i] > 9)
    {
      sprintf(temp,"%d",arr[i]);
      for(size_t j = 0; temp[j] != '\0'; ++j) printf("%c ",temp[j]);
    }
    else printf("%d ",arr[i]);
  }
  puts("");
}

int main(void)
{
  int arr1[] = {1,34,5,6};  
  int arr2[] = {1,24,51,60};
  size_t sz1 = 4, sz2 = 4;
  separate_digits(arr1,sz1);
  separate_digits(arr2,sz2);
  return 0;
}

