#include <stdio.h>
#include <string.h>

void update_characters(int i, char *characters){
  char hold1[32] = "", hold2[32] = "";
  strncpy(hold1, characters, i);
  strncpy(hold2, characters + i + 1, strlen(characters) - i - 1);
  strcat(hold1, hold2);
  memset(characters, 0, strlen(characters));
  strcpy(characters, hold1);
}

// Check for w in chars array, and remove it.
int check(char w, char *characters) {
  for (int i=0; i < strlen(characters); i++) {
    char c = characters[i];
    if (w == c) {
      update_characters(i, characters);
      return 1;
    }
  }
  return 0;
}

int contrib(char *word, char *chars) {
  int chars_length = strlen(chars);
  int word_length = strlen(word);
  char characters[chars_length];
  strncpy(characters, chars, chars_length);
  for (int j = 0; j < word_length; j++) {
    char w = word[j];
    if ( check(w, characters) == 0 ) {
      return 0;
    }
  }
  return word_length;
}

void proc(char *chars, char words[][32], int wlen) {
  int sum = 0;
  int i = 0;
  while (i < wlen) {
    sum += contrib(words[i], chars);  
    i++;
  }
  printf("Input: chars = '%s',\n", chars);
  printf("\t words = (");
  i = 0;
  while (i < wlen - 1) {
    printf("'%s', ", words[i]);
    i++;
  }
  printf("'%s')\n", words[wlen-1]);
  printf("Output: %d\n", sum);
}

int main() {
  char chars[] = "atach";
  char words[4][32];
  strcpy(words[0], "cat");
  strcpy(words[1], "bt");
  strcpy(words[2], "hat");
  strcpy(words[3], "tree");  

  char chars2[] = "welldonehopper";
  char words2[3][32];
  strcpy(words2[0], "hello");
  strcpy(words2[1], "world");
  strcpy(words2[2], "challenge");

  proc(chars, words, 4);
  proc(chars2, words2, 3);
  
  return 0;
}
