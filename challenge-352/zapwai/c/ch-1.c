#include <stdio.h>
#include <string.h>
#include <stdbool.h>

void proc(char **words, int N) {
  printf("Input: ");
  for (int i = 0; i < N; i++)
    printf("%s ", words[i]);
  printf("\n");
  char *subs[N] = {};
  int sublen = 0;
  for (int i = 0; i < N; i++) {
    char *word = words[i];
    for (int j = 0; j < N; j++) {
      if (i == j)
	continue;
      char *subword = words[j];
      bool skip = false;
      for (int k = 0; k < sublen; k++) {
	if (strcmp(subs[k], subword) == 0) {
	  skip = true;
	  break;
	}
      }
      if (skip) {
	continue;
      }
      char *p;
      p = strstr(word, subword);
      if (p != NULL) {
	subs[sublen++] = subword;
      }
    }
  }
  printf("Output: ");
  for (int i = 0; i < sublen; i++)
    printf("%s ", subs[i]);
  printf("\n");
}

int main() {
  char *words[] = {"cat", "cats", "dog", "dogcat", "dogcat", "rat", "ratcatdogcat"};
  int N = sizeof(words) / sizeof(char*);
  proc(words, N);
  char *words2[] = {"car", "carpet", "carpenter", "pet", "enter", "pen", "pent"};
  N = sizeof(words2) / sizeof(char*);
  proc(words2, N);
}
