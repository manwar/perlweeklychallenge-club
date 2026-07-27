#include <stdio.h>
#include <stdbool.h>
#include <string.h>
#include <stdlib.h>
#define MAXLEN 20

// Check if grouped consecutively
bool grouped(char *word) {
  int len = strlen(word);
  int k = len/2;
  char c = word[0];
  for (int i = 0; i < k; i++) {
    if (word[i] != c) return false;
  }
  return true;
}

bool contained(int listlen, char *list[listlen], char *word) {
  for (int i = 0; i < listlen; i++) {
    if (strcmp(list[i], word) == 0) {
      return true;
    }
  }
  return false;
}

bool eq_cnt(char *word) {
  int zero = 0, one = 0;
  int len = strlen(word);
  for (int i = 0; i < len; i++) {
    if (word[i] == '0') {
      zero++;
    } else {
      one++;
    }
  }
  return (one == zero);
}

void proc(char *num) {
  printf("Input: %s\n", num);
  int len = strlen(num);
  char *list[MAXLEN] = {};
  int listlen = 0;
  for (int i = 0; i < len; i++) {
    for (int j = 1; j <= len - i; j++) {
      char *word = malloc(MAXLEN);
      strncpy(word, num + i, j);
      if (eq_cnt(word)) {
	if (grouped(word)) {
	  if (!contained(listlen, list, word)) {
	    list[listlen] = malloc(MAXLEN);
	    strcpy(list[listlen++], word);
	  }
	}
      }
    }
  }
  printf("Output: ");
  for (int i = 0; i < listlen; i++) {
    printf("%s ", list[i]);
  }
  printf("\n");
}

int main() {
  char *binary = "0101";
  proc(binary);
  binary = "000111";
  proc(binary);
  binary = "000011";
  proc(binary);
  binary = "10011100";
  proc(binary);
  binary = "00000";
  proc(binary);
}
