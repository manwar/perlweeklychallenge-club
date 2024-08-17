#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#define MAX 50

void proc(char mystr[]) {
  printf("Input: %s\n", mystr);
  char *words[MAX];
  int keys[MAX] = {};
  int sentencelen = 0;
  char *token = strtok(mystr, " ");
  while (token != NULL) {
    int len = strlen(token);
    keys[sentencelen] = token[len - 1] - '0';
    words[sentencelen] = malloc(len * sizeof(char));
    strncpy(words[sentencelen], token, len - 1);
    sentencelen++;
    token = strtok(NULL, " ");
  }
  int cnt = 1;
  while (cnt > 0) {
    cnt = 0;
    for (int i = 0; i < sentencelen - 1; i++) {
	if (keys[i] > keys[i + 1]) {
	  int keynum = keys[i];
	  keys[i] = keys[i + 1];
	  keys[i + 1] = keynum;
	  char *word = words[i];
	  words[i] = words[i + 1];
	  words[i + 1] = word;
	  cnt++;
	}
      }
  }
  printf("Output: ");
  for (int i = 0; i < sentencelen; i++) {
    printf("%s ", words[i]);
    free(words[i]);
  }
  printf("\n");
}

int main() {
  char mystr[] = "and2 Raku3 cousins5 Perl1 are4";
  proc(mystr);
  char mystr2[] = "guest6 Python1 most4 the3 popular5 is2 language7";
  proc(mystr2);
  char mystr3[] = "Challenge3 The1 Weekly2";
  proc(mystr3);
}

