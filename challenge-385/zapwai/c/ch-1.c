#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h>
#define MAXLEN 30

void proc(char *s1, char *s2) {
  printf("Input:  s1 = %s\n\ts2 = %s\n", s1, s2);
  char sent1[strlen(s1)+1] = {};
  strcpy(sent1, s1);
  char sent2[strlen(s2)+1] = {};
  strcpy(sent2, s2);

  char *keys[50];
  int vals[50];
  int klen = 0;

  char *p;
  p = strtok(sent1, " ");
  while (p != NULL) {
    char *word = malloc(MAXLEN);
    strcpy(word, p);
    // Check for the existence of this word, and increment, or add to keys/vals.
    bool found = false;
    for (int i = 0; i < klen; i++) {
      if (strcmp(keys[i], word) == 0) {
	vals[i]++;
	found = true;
      }
    }
    if (!found) {
      keys[klen] = malloc(MAXLEN);
      strcpy(keys[klen], word);
      vals[klen++] = 1;
    }
    p = strtok(NULL, " ");
  }
  p = strtok(sent2, " ");
  while (p != NULL) {
    char *word = malloc(MAXLEN);
    strcpy(word, p);
    bool found = false;
    for (int i = 0; i < klen; i++) {
      if (strcmp(keys[i], word) == 0) {
	vals[i]++;
	found = true;
      }
    }
    if (!found) {
      keys[klen] = malloc(MAXLEN);
      strcpy(keys[klen], word);
      vals[klen++] = 1;
    }
    p = strtok(NULL, " ");
  }

  printf("Output: ");
  for (int i = 0; i < klen; i++) {
    if (vals[i] == 1) {
      printf("%s ", keys[i]);
    }
  }
  
  printf("\n");
}

int main() {
  char *s1 = "apple banana apple";
  char *s2 = "banana orange";
  proc(s1, s2);

  s1 = "cat dog";
  s2 = "bird fish";
  proc(s1, s2);

  s1 = "the quick brown fox";
  s2 = "the quick";
  proc(s1, s2);

  s1 = "hello";
  s2 = "hello";
  proc(s1, s2);

  s1 = "blue blue red";
  s2 = "red green green yellow";
  proc(s1, s2);
}
