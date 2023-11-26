#include<stdio.h>
#include<stdlib.h>
#include<ctype.h>
#include<string.h>

int acronym(const char **arr,
	    size_t sz,
	    const char *check)
{
  char *ret = malloc(sz+1 * sizeof(**arr));
  ret[sz] = '\0';
  size_t k = 0;
  for(size_t i = 0; i < sz; ++i) ret[k++] = tolower(arr[i][0]);
  int res = strcmp(ret,check);
  free(ret);
  return res == 0 ? 1 : 0;
}

int main(void)
{
  const char *arr1[] = {"Perl","Python","Pascal"};
  const char *arr2[] = {"Perl","Raku"};
  const char *arr3[] = {"Oracle","Awk","C"};
  size_t sz1 = 3,sz2 = 2,sz3 = 3;
  printf("%d\n", acronym(arr1,sz1,"ppp"));
  printf("%d\n", acronym(arr2,sz2,"rp"));
  printf("%d\n", acronym(arr3,sz3,"oac"));
  return 0;
}

