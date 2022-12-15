#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b)
{ 
  int i1 = *(int*)a;
  int i2 = *(int*)b;
  return i2 - i1;
}

int frequency_equalizer(const char *str)
{
  int freq[26] = {0}, *arr = NULL, res = 0, j = 0;
  size_t count = 0;
  for(int i = 0; str[i] != '\0'; ++i) freq[str[i] - 'a']++;
  for(int i = 0; i < 26; ++i) if(freq[i] != 0) count++;
  arr = malloc(count * sizeof(int));
  for(int i = 0; i < 26; ++i) if(freq[i] != 0) arr[j++] = freq[i];
  qsort(arr, count, sizeof(int),compare);
  res = (arr[0] == arr[1]+1) && (arr[count-1] == arr[1]) ? 1 : 0;
  if(arr){
    free(arr);
    arr = NULL;
  } 
  return res;
}

int main(void)
{
  printf("%d\n", frequency_equalizer("abbc"));
  printf("%d\n", frequency_equalizer("xyzyyxz"));
  printf("%d\n", frequency_equalizer("xzxz"));
  return 0;
}
