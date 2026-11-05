#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define WORDLEN 50

char *diff(char *s) {
  char *alph = "abcdefghijklmnopqrstuvwxyz";
  char *o = malloc(WORDLEN);
  o[0] = '\0';
  int slen = strlen(s);
  for (int i = 0; i < slen - 1; i++) {
    int l2 = s[i+1] - 'a';
    int l1 = s[i] - 'a';
    char *buf = malloc(50);
    sprintf(buf, "%d ", l2-l1);
    strcat(o, buf);
  }
  //  printf("o: %s\n", o);
  return o;
}

void proc(int m, char *w[m]) {
  printf("Input: ");
  for (int i = 0; i < m; i++)
    printf("%s ", w[i]);
  printf("\n");
  char *wordstring[m];

  for (int i = 0; i < m; i++) {
    wordstring[i] = malloc(WORDLEN);
    strcpy(wordstring[i], diff(w[i]));
  }
  
  char *common = malloc(WORDLEN);

  for (int i = 0; i < m - 1; i++) {
    if (strcmp(wordstring[i], wordstring[i+1]) == 0) {
      strcpy(common, wordstring[i]);
      break;
    }
  }
  
  int ind = 0;
  for (int i = 0; i < m; i++) {
    if (strcmp(wordstring[i], common) == 0) continue;
    ind = i;
    break;
  }
  printf("Output: %s\n", w[ind]);
}

int main() {
  char *words[] = {"ab", "bc", "cd", "zy"};
  proc(sizeof(words)/sizeof(char*), words);
  char *words2[] = {"cba", "fed", "azy"};
  proc(sizeof(words2)/sizeof(char*), words2);
  char *words3[] = {"pop", "ada", "beb", "cfc"};
  proc(sizeof(words3)/sizeof(char*), words3);
  char *words4[] = {"aaaa", "zzzz", "mmmm", "aaba"};
  proc(sizeof(words4)/sizeof(char*), words4);
  char *words5[] = {"aceg", "bdfh", "cegi", "azbz"};
  proc(sizeof(words5)/sizeof(char*), words5);
}
