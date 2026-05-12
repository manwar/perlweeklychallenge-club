#include <stdio.h>
#include <string.h>

void proc(int m, int n, char *arr1[m], char *arr2[n]) {
  printf("Input:  arr1 = ");
  for (int i = 0; i < m; i++)
    printf("\"%s\" ", arr1[i]);
  printf("\n\tarr2 = ");
  for (int i = 0; i < n; i++)
    printf("\"%s\" ", arr2[i]);
  printf("\n");
  char s1[100] = {}, s2[100] = {};
  for (int i = 0; i < m; i++)
    strcat(s1, arr1[i]);
  for (int i = 0; i < n; i++)
    strcat(s2, arr2[i]);
  printf("Output: %s\n\n", 
	 (strcmp(s1, s2) == 0) ? "true" : "false" );
}

int main() {
  char *arr1[] = {"a", "bc"};
  char *arr2[] = {"ab", "c"};
  proc(2, 2, arr1, arr2);
  char *barr1[3] = {"a", "b", "c"};
  char *barr2[2] = {"a", "bc"};
  proc(sizeof(barr1)/sizeof(char*), sizeof(barr2)/sizeof(char*), barr1, barr2);
  char *carr1[] = {"a", "bc"};
  char *carr2[] = {"a", "c", "b"};
  proc(sizeof(carr1)/sizeof(char*), sizeof(carr2)/sizeof(char*), carr1, carr2);
  char *darr1[] = {"ab", "c", ""};
  char *darr2[] = {"", "a", "bc"};
  proc(sizeof(darr1)/sizeof(char*), sizeof(darr2)/sizeof(char*), darr1, darr2);
  char *earr1[] = {"p", "e", "r", "l"};
  char *earr2[] = {"perl"};
  proc(sizeof(earr1)/sizeof(char*), sizeof(earr2)/sizeof(char*), earr1, earr2);
}
