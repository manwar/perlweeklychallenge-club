#include <stdio.h>
#include <string.h>
#include <stdbool.h>
#include <stdlib.h>

int value(char *w1, char *w2) {
  return strlen(w1)*strlen(w2);
}

bool same_letters(char *w1, char *w2) {
  int w1len = strlen(w1);
  int w2len = strlen(w2);
  for (int i = 0; i < w1len; i++) {
    char l1 = w1[i];
    for (int j = 0; j < w2len; j++) {
      char l2 = w2[j];
      if (l1 == l2)
	return true;
    }
  }
  return false;
}

void proc(int m, char *words[m]) {
  printf("Input: ");
  for (int i = 0; i < m; i++)
    printf("\"%s\" ", words[i]);
  printf("\n");

  int max_val = 0;
  char *outword1 = malloc(30), *outword2 = malloc(30);
  outword1[0] = '\0';
  outword2[0] = '\0';
  
  for (int i = 0; i < m - 1; i++) {
    char *word1 = words[i];
    for (int j = i + 1; j < m; j++) {
      char *word2 = words[j];
      if (!same_letters(word1, word2)) {
	int val = value(word1, word2);
	if (val > max_val) {
	  max_val = val;
	  strcpy(outword1, word1);
	  strcpy(outword2, word2);
	}
      }
    }
  }
  
  printf("Output: %d\t", max_val);
  if (outword1[0] != '\0' && outword2[0] != '\0')
    printf("(%s, %s)\n", outword1, outword2);
  free(outword1); free(outword2);
  printf("\n");
}

int main() {
  char *words[6] = {"a", "ab", "abc", "d", "de", "def"};
  proc(6, words);
  char *words2[] = {"a", "aa", "aaa", "aaaa"};
  proc(4, words2);
  char *words3[] = {"meet", "app", "code", "sky", "bold"};
  proc(5, words3);
  char *words4[] = {"a", "ab", "abc", "abcd", "efghi"};
  proc(5, words4);
  char *words5[] = {"xyz", "w", "abcdefg", "hij"};
  proc(4, words5);
}
