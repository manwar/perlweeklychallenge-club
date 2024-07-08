#include <stdio.h>
#include <string.h>
#include <stdbool.h>

bool is_multi(char* word, char* words[], int wordslen) {
  int cnt = 0;
  for (int i = 0; i < wordslen; i++) {
    char* w = words[i];
    if (word == w)
      cnt++;
  } 
  return (cnt == 1) ? false : true;
}

void proc(char* words1[], int words1len, char* words2[], int words2len) {
  printf("Input:");
  for (int i = 0; i < words1len; i++)
    printf("%s ", words1[i]);
  printf("| ");
  for (int i = 0; i < words2len; i++)
    printf("%s ", words2[i]);
  printf("\n");
  int cnt = 0;

  for (int i = 0; i < words1len; i++) {
    char* word1 = words1[i];
    if (is_multi(word1, words1, words1len))
      continue;
    for (int j = 0; j < words2len; j++) {
      char* word2 = words2[j];
      if (is_multi(word2, words2, words2len))
	continue;
      if (strcmp(word1, word2) == 0)
	cnt++;
    }
  }
  printf("Output: %d\n", cnt);
}

int main() {
  char* words1[] = {"Perl", "is", "my", "friend"};
  char* words2[] = {"Perl", "and", "Raku", "are", "friend"};
  proc(words1, sizeof(words1)/sizeof(char*), words2, sizeof(words2) / sizeof(char*));
  char* words3[] = {"Perl", "and", "Python", "are", "very", "similar"};
  char* words4[] = {"Python", "is", "top", "in", "guest", "languages"};
  proc(words3, sizeof(words3)/sizeof(char*), words4, sizeof(words4) / sizeof(char*));
}
