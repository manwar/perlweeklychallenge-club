#include<stdio.h>
#include<stdlib.h>

int compare_chars(const void *a, const void *b)
{
  char arg1 = *(const char*)a;
  char arg2 = *(const char*)b;
  return(arg1 > arg2) - (arg1 < arg2);
}

char greater_character(char *arr, size_t sz, char target)
{
  qsort((void*)arr, sz, sizeof(char), compare_chars);
  for(size_t i = 0; i < sz; ++i)
  {
    if(arr[i] > target) return arr[i];
  }
  return target;
}

int main()
{
  char a1[4] = {'e','m','u','g'};
  char a2[4] = {'d','c','e','f'};
  char a3[3] = {'j','a','r'};
  char a4[4] = {'d','c','a','f'};
  char a5[4] = {'t','g','a','l'};
  size_t sz1 = 4, sz2 = 3;
  printf("%c\n", greater_character(a1, sz1, 'b'));
  printf("%c\n", greater_character(a2, sz1, 'a'));
  printf("%c\n", greater_character(a3, sz2, 'o'));
  printf("%c\n", greater_character(a4, sz1, 'a'));
  printf("%c\n", greater_character(a5, sz1, 'v')); 
  return 0;
}

