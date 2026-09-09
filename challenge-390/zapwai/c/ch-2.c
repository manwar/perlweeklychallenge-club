#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <time.h>
#include <stdbool.h>
#define MAXLEN 30
#define COLLMAX 1000
#define ROUNDS 10000
int cmp_str(const void *a, const void *b) {
  const char *const *sa = a;
  const char *const *sb = b;
  return strcmp(*sa, *sb);
}

char *append(char *s, int k) {
  int r = rand() % k;
  int len = strlen(s);
  char o[len+1] = {};
  o[len] = '\0';
  o[len - 1] = s[r];
  for (int i = 0; i < r; i++)
    o[i] = s[i];
  for (int i = r + 1; i < len; i++)
    o[i - 1] = s[i];
  char *out = malloc(MAXLEN);
  strcpy(out, o);
  return out;
}

void proc(char *str, int k) {
  printf("Input: str = %s, k = %d\n", str, k);
  char *collection[COLLMAX] = {};
  int clen = 0;
  char *s = str;
  for (int i = 0; i < ROUNDS; i++) {
    char *new_s = append(s, k);
    if (s != str)
      free(s);
    s = new_s;
    bool found = false;
    for (int j = 0; j < clen; j++) {
      if (0 == strcmp(collection[j], s)) {
	found = true;
	break;
      }
    }
    if (!found) {
      collection[clen] = malloc(MAXLEN);
      strcpy(collection[clen++], s);
    }
  }

  qsort(collection, clen, sizeof(char *), cmp_str);
  printf("Output: %s\n", collection[0]);
  for (int i = 0; i < clen; i++)
    free(collection[i]);
}

int main() {
  srand(time(NULL));
  char *str = "dbca";
  int k = 1;
  proc(str, k);
  str = "geeks"; k = 2;
  proc(str, k);
  str = "cbaed"; k = 3;
  proc(str, k);
  str = "fedcba"; k = 4;
  proc(str, k);
  str = "perl"; k = 1;
  proc(str, k);
}

