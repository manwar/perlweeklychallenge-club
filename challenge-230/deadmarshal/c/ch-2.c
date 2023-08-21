#include<stdio.h>
#include<string.h>

size_t count_words(const char **arr,
		   size_t sz,
		   const char *pat)
{
  size_t count = 0;
  for(size_t i = 0; i < sz; ++i)
    if(strncmp(pat,arr[i],strlen(pat)) == 0) count++;
  return count;
}

int main()
{
  const char *arr1[] = {"pay", "attention", "practice", "attend"};
  const char *arr2[] = {"janet", "julia", "java", "javascript"};
  const char pat1[] = "at";
  const char pat2[] = "ja";
  size_t sz1 = 4, sz2 = 4;
  printf("%zu\n",count_words(arr1,sz1,pat1));
  printf("%zu\n",count_words(arr2,sz2,pat2));
  return 0;
}

