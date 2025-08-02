#include <stdio.h>
#include <string.h>
#include <stdbool.h>
#include <stdlib.h>
#define MAX 30

bool isVowel(char c) {
  return (c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u'
	  || c == 'A' || c == 'E' || c == 'I' || c == 'O' || c == 'U');
}

void proc(char sent[]) {
  printf("Input: %s\n", sent);
  char* words[MAX];
  char* token = strtok(sent, " ");
  int wordslen = 0;
  while (token != NULL) {
    words[wordslen] = malloc(MAX);
    strcpy(words[wordslen++], token);
    token = strtok(NULL, " ");
  }
  char* output = malloc(MAX*sizeof(char));
  for (int i = 0; i < wordslen; i++) {
    char first_let = words[i][0];
    char reword[MAX] = {};
    int J = strlen(words[i]);
    for (int j = 1; j < J; j++) {
      reword[j-1] = words[i][j];
    }
    reword[J - 1] = first_let;
    reword[J] = '\0';
    char A[MAX] = {};
    for (int j = 0; j <= i; j++) 
      strcat(A, "a");
    if (isVowel(first_let)) {
      strcat(output, words[i]);
      strcat(output, "ma");
      strcat(output, A);
      strcat(output, " ");
    } else {
      strcat(output, reword);
      strcat(output, "ma");
      strcat(output, A);
      strcat(output, " ");
    }
  }
  printf("Output: %s\n", output);
  free(output);
  for (int i = 0; i < wordslen; i++)
    free(words[i]);
}

int main() {
  char sent[] = "I love Perl";
  proc(sent);
  char sent2[] = "Perl and Raku are friends";
  proc(sent2);
  char sent3[] = "The Weekly Challenge";
  proc(sent3);
}
