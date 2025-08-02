#ifndef PWC005_H
#define PWC005_H
// Requires stdlib and string (I use them in main)
#define MAX_WORDS 300000
#define MAX_WORD_LENGTH 50

void alphaset(char**, int, char**);
void alph(int, char*);
char* lc(char*);
void dictset(char**, int*);

void alphaset(char** alpha, int dict_length, char** dict) {
  for (int i = 0; i < dict_length; i++){
    dict[i] = lc(dict[i]);
    alpha[i] = malloc(strlen(dict[i]) + 1);
    strcpy(alpha[i], dict[i]);
    alph(strlen(alpha[i]), alpha[i]);
  }
}

void alph(int wordlen, char* word) {
  int cnt;
  do {
    cnt = 0;
    for (int i = 0; i < wordlen - 1; i++) {
      if (word[i] > word[i + 1]) {
	cnt++;
	char tmp = word[i];
	word[i] = word[i + 1];
	word[i + 1] = tmp;
      }
    }
  } while(cnt > 0);
}

char* lc(char* word) {
  char* myword = strdup(word);
  char* Alph = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  char* alph = "abcdefghijklmnopqrstuvwxyz";  
  for (int i = 0; i < strlen(word); i++) {
    for (int j = 0; j < strlen(Alph); j++) {
      if (myword[i] == Alph[j]) {
	myword[i] = alph[j];
      }
    }
  }
  return myword;
}

void dictset(char** dict, int* dict_length) {
  FILE* fp = fopen("/usr/share/dict/words", "r");
  if (fp == NULL) {
    fprintf(stderr, "Cannot open words file.\n");
  }
  char buffer[MAX_WORD_LENGTH];
  int i = 0;
  while (fgets(buffer, MAX_WORD_LENGTH, fp)) {
    size_t length = strlen(buffer);
    dict[i] = malloc(length + 1);
    if (buffer[length - 1] == '\n') {
      buffer[length - 1] = '\0';
    }
    strncpy(dict[i], buffer + 0, length);
    i++;
  }
  fclose(fp);
  *dict_length = i;
}

#endif
