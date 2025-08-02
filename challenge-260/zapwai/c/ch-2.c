#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#define MAX_WORD_LEN 50

void sortme(char** words, int wordlen) {
  int cnt;
  do {
    cnt = 0;
    for (int i = 0; i < wordlen - 1; i++)
      if (strcmp(words[i+1], words[i]) < 0) {
	char* tmp = words[i+1];
	words[i+1] = words[i];
	words[i] = tmp;
	cnt++;
      }
  } while (cnt > 0);
}

void insert_uniquely(char* word, int wordlen, char** h, int* hlen) {
  for (int i = 0; i < *hlen; i++)
    if (0 == strcmp(h[i], word))
      return;
  h[*hlen] = malloc(MAX_WORD_LEN * sizeof(char));
  strncpy(h[*hlen], word, wordlen);
  ++*hlen;
}

int seek_word(char* word, char** sorted, int sortlen) {
  for (int i = 0; i < sortlen; i++)
    if (0 == strcmp(sorted[i], word))
      return i;
  return -1;
}

void swap(int i, int j, char list[]) {
  char tmp = list[i];
  list[i] = list[j];
  list[j] = tmp;
}

void L(int k, char list[], char** h, int *hlen, int wordlength) {
  if (k == 1)
    insert_uniquely(list, wordlength, h, hlen);
  else {
    L(k - 1, list, h, hlen, wordlength);
    for (int i = 0; i <= k - 2; i++) {
      if (k % 2 == 0)
	swap(i, k-1, list);
      else
	swap(0, k-1, list);
      L(k - 1, list, h, hlen, wordlength);
    }
  }
}

void proc(char* word) {
  printf("Input: %s\n", word);
  char** h = malloc(1000 * sizeof(char*));
  int hlen = 0;

  char list[strlen(word)];
  for (int i = 0; i < strlen(word); i++)
    list[i] = word[i];

  L(strlen(word), list, h, &hlen, strlen(word));
  
  sortme(h, hlen);

  int ind = seek_word(word, h, hlen);
  printf("Output: %d\n", 1 + ind);
  for (int i = 0; i < hlen; i++)
    free(h[i]);
  free(h);
}

int main() {
  proc("CAT");
  proc("GOGGLE");
  proc("SECRET");
}
