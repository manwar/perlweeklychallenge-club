#include<stdio.h>

int is_alphabetical_order(const char *const str)
{
  for(size_t i = 1; str[i] != '\0'; ++i)
    if(str[i] < str[i-1]) return 0;
  return 1;
}

size_t odd_one_out(const char **arr, size_t sz)
{
  size_t count = 0;
  for(size_t i = 0; i < sz; ++i)
    if(!is_alphabetical_order(arr[i])) count++;
  return count;
}

int main(void)
{
  const char *a1[] = {"abc","xyz","tsu"};
  const char *a2[] = {"rat","cab","dad"};
  const char *a3[] = {"x","y","z"};
  size_t sz = 3;
  printf("%zu\n", odd_one_out(a1,sz));
  printf("%zu\n", odd_one_out(a2,sz));
  printf("%zu\n", odd_one_out(a3,sz));
  return 0;
}

