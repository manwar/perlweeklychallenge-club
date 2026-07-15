#include <stdio.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>
#define MAX 50

void proc(char *s) {
  printf("Input: str = \"%s\"\n", s);
  if (strchr(s,'?') != NULL) {
    int len = strlen(s);
    char *branch[(int) pow(2,len)] = {};
    int brlen = 0;
    int index = 0;
    for (int i = 0; i < len; i++) {
      if (s[i] == '?') {
	index = i;
	branch[brlen] = malloc(MAX);
	snprintf(branch[brlen++], i+1, "%s", s);
	break;
      }
    }
    for (int i = index; i < len; i++) {
      if (s[i] == '?') {
	char *new_branch[2*brlen] = {};
	int nbrlen = 0;
	for (int j = 0; j < brlen; j++) {
	  char *word1 = malloc(MAX);
	  sprintf(word1, "%s%c", branch[j], '0');
	  new_branch[nbrlen] = malloc(MAX);
	  strcpy(new_branch[nbrlen++], word1);
	  char *word2 = malloc(MAX);
	  sprintf(word2, "%s%c", branch[j], '1');
	  new_branch[nbrlen] = malloc(MAX);
	  strcpy(new_branch[nbrlen++], word2);
	}
	for (int j = 0; j < nbrlen; j++) {
	  if (j >= brlen)
	    branch[j] = malloc(MAX);
	  strcpy(branch[j], new_branch[j]);
	}
	brlen = nbrlen;
      } else {
	for (int j = 0; j < brlen; j++) {
	  char *word = malloc(MAX);
	  sprintf(word, "%s%c", branch[j], s[i]);
	  strcpy(branch[j], word);
	}
      }
    }

    printf("Output: ");
    for (int j = 0; j < brlen; j++) {
      printf("%s ", branch[j]);
      free(branch[j]);
    }
    printf("\n");
  } else {
    printf("Output: %s\n", s);
  }
}

int main() {
  char *s = "01??0";
  proc(s);
  s = "101";
  proc(s);
  s = "???";
  proc(s);
  s = "1?10";
  proc(s);
  s = "1?1?0";
  proc(s);
}
