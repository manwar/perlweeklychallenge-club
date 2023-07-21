#include<stdio.h>
#include<stdlib.h>

char *shuffle_string(const char *str,
		     int *arr,
		     size_t sz)
{
  char *ret = malloc(sz * sizeof(char));
  for(size_t i = 0; i < sz; ++i) ret[arr[i]] = str[i];
  return ret;
}

int main()
{
  const char str1[] = "lacelengh";
  int arr1[] = {3,2,0,5,4,8,6,7,1};
  const char str2[] = "rulepark";
  int arr2[] = {4,7,3,1,0,5,2,6};
  size_t sz1 = 9, sz2 = 8;
  char *ret1 = shuffle_string(str1,arr1,sz1);
  char *ret2 = shuffle_string(str2,arr2,sz2);
  printf("%s\n",ret1);
  printf("%s\n",ret2);
  if(ret1)
  {
    free(ret1);
    ret1 = NULL;
  }
  if(ret2)
  {
    free(ret2);
    ret2 = NULL;
  }
  return 0;
}

