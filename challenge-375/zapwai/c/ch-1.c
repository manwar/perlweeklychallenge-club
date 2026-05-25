#include <stdio.h>
#include <stdbool.h>
#include <string.h>

bool occurs_once(char *word, int n, char *array[n]) {
  int cnt = 0;
  for (int i = 0; i < n; i++) {
    if (strcmp(array[i], word) == 0)
      cnt++;
  }
  return (cnt == 1);
}

void proc(int m, int n, char *array1[m], char *array2[n]) {
  printf("Input: \n");
  printf(" array1: ");
  for (int i = 0; i < m; i++)
    printf("%s ", array1[i]);
  printf("\n");
  printf(" array2: ");
  for (int i = 0; i < n; i++)
    printf("%s ", array2[i]);
  printf("\n");

  int cnt = 0;
  for (int i = 0; i < m; i++)
    if (occurs_once(array1[i], m, array1))
      if (occurs_once(array1[i], n, array2))
	cnt++;

  printf("Output: %d\n\n", cnt);
}

int main() {
  char *array1[] = { "apple", "banana", "cherry" };
  char *array2[] = { "banana", "cherry", "date" };
  int m = sizeof(array1) / sizeof(char*);
  int n = sizeof(array2) / sizeof(char*);
  proc(m, n, array1, array2);

  char *array1b[] = { "a", "ab", "abc" };
  char *array2b[] = { "a", "a", "ab", "abc" };
  m = sizeof(array1b) / sizeof(char*);
  n = sizeof(array2b) / sizeof(char*);
  proc(m, n, array1b, array2b);

  char *array1c[] = { "orange", "lemon" };
  char *array2c[] = { "grape", "melon" };
  m = sizeof(array1c) / sizeof(char*);
  n = sizeof(array2c) / sizeof(char*);
  proc(m, n, array1c, array2c);

  char *array1d[] = { "test", "test", "demo" };
  char *array2d[] = { "test", "demo", "demo" };
  m = sizeof(array1d) / sizeof(char*);
  n = sizeof(array2d) / sizeof(char*);
  proc(m, n, array1d, array2d);

  char *array1e[] = { "Hello", "world" };
  char *array2e[] = { "hello", "world" };
  m = sizeof(array1e) / sizeof(char*);
  n = sizeof(array2e) / sizeof(char*);
  proc(m, n, array1e, array2e);
}
