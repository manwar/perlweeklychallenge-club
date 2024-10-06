#include <string.h>
#include <stdio.h>
#include <time.h>
#include <stdlib.h>
#include <stdbool.h>
#define NUMWORDS 1000
#define WORDLEN 50

char* jumble(char* word) {
  if (strlen(word) < 4)
    return word;
  int start = word[0];
  int end = word[strlen(word) - 1];
  int letlen = strlen(word) - 2;
  char let[50];
  for (int i = 0; i < letlen; i++) {
    let[i] = word[i+1];
  }
  int order[WORDLEN];
  int orderlen = 0;
  while (orderlen < letlen) {
    int x = rand() % (letlen);
    bool got = false;
    for (int i = 0; i < orderlen; i++)
      if (order[i] == x)
	got = true;
    if (!got)
      order[orderlen++] = x;
  }
  int midlen = 0;
  char middle[WORDLEN] = {};
  for (int i = 0; i < orderlen; i++)
    middle[midlen++] = let[order[i]];
  char* q = malloc(strlen(word) + 1);
  sprintf(q, "%c%s%c", start, middle, end);
  return q;
}

void proc(char s[]) {
  printf( "Input: %s\n", s);
  int wordslen = 0;
  char* words[NUMWORDS];
  char *p = strtok(s, " ");
  
  while(p != NULL) {
    words[wordslen] = malloc(WORDLEN);
    strcpy(words[wordslen++], p);
    p = strtok(NULL, " ");
  }

  int newlistlen = 0;
  char* newlist[NUMWORDS];
  
  for (int i = 0; i < wordslen; i++) {
    newlist[newlistlen] = malloc(WORDLEN);
    strcpy(newlist[newlistlen++], jumble(words[i]));
    free(words[i]);
  }
  
  printf("Output: ");
  for (int i = 0; i < newlistlen; i++) {
    printf("%s ", newlist[i]);
    free(newlist[i]);
  }
  printf("\n");
}

int main() {
  srand(time(NULL));
  char s[] = "This supposed Cambridge research is unfortunately an urban legend";
  proc(s);
}
