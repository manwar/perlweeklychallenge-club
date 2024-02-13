#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void proc(char**, int);
char* rev_word(char*);

int main() {
  char* words[] = {"ab", "de", "ed", "bc"};
  int len = sizeof(words) / sizeof(words[0]);  /* Assuming that each word is the same length. */
  proc(words, len);

  char* words2[] = {"aa", "ba", "cd", "ed"};
  int len2 = sizeof(words2) / sizeof(words2[0]);
  proc(words2, len2);
  
  char* words3[] = {"uv", "qp", "st", "vu", "mn", "pq"};
  int len3 = sizeof(words3) / sizeof(words3[0]);
  proc(words3, len3);  
}

void proc(char* words[], int len) {
  int count = 0;
  for (int i = 0; i < len - 1; i++) {
    for (int j = i + 1; j < len; j++) {
      if (!strcmp(words[i], rev_word(words[j]))) {
	count++;
      }
    }
  }
  printf("Input: {");
  for (int i = 0; i < len - 1; i++) {
    printf("%s, ", words[i]);
  }
  printf("%s}\n", words[len - 1]);
  printf("Output: %d\n\n", count);
}

char* rev_word(char* stringy) {
  int e = strlen(stringy);
  char* word = (char*) malloc( (e + 1)*sizeof(char) ); /* Did not bother to free this */
  strcpy(word, stringy);
  e--;
  int s = 0;
  while (e > s) {
    char temp = word[s];
    word[s] = word[e];
    word[e] = temp;
    e--;
    s++;
  }
  return word;
}
