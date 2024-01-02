#include<stdio.h>
#include<stdlib.h>
#include<ctype.h>
#include<string.h>

int is_numeric(const char *str)
{
  for(size_t i = 0; str[i] != '\0'; ++i) if(!isdigit(str[i])) return 0;
  return 1;
}

size_t alphanumeric_string_value(const char **arr,size_t sz)
{
  size_t max = 0;
  for(size_t i = 0; i < sz; ++i){
    size_t n = is_numeric(arr[i]) ? strtol(arr[i],NULL,10) : strlen(arr[i]);
    if(n > max) max = n;
  }  
  return max;
}

int main(void)
{
  const char *arr1[] = {"perl","2","000","python","r4ku"};
  const char *arr2[] = {"001","1","000","0001"};
  size_t sz1 = 5,sz2 = 4;
  printf("%zu\n",alphanumeric_string_value(arr1,sz1));
  printf("%zu\n",alphanumeric_string_value(arr2,sz2));
  return 0;
}

