#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

#define max_length 100		/* max length of lines */
#define num_lines 30		/* max # of lines in file */

void proc(char*);
bool is_in(char, char*, bool*);

int main() {
  char* alist = "docgotrark";
  proc(alist);
  return 0;
}

void proc(char* alist) {
  FILE* fh = fopen("004-file.txt", "r");
  if (fh == NULL) { printf("Error opening file\n"); }
  char words[num_lines][max_length]; /* words from file */
  bool blist[strlen(alist)];	     /* keeps track of letters available */
  int i = 0;
  while (fgets(words[i], max_length, fh) != NULL) {
    i++;
  }
  fclose(fh);
  int N = i;			/* num of words in file */
  char list[N][max_length]; /* answer list */
  printf("Input: %s\n", alist);
  printf("Output: ");
  int list_len = 0;		/* num of words in answer list */
  for (int i = 0; i < N; i++){	/* for each word in file */
    for (int i = 0; i < strlen(alist); i++) { /* reset available letters */
      blist[i] = true;
    }
    int cnt = 0;		/* count available letters in each word */
    for (int j = 0; j < strlen(words[i]) - 1; j++){ /* skip the \n on the end */
      if ( is_in(words[i][j], alist, blist) ) {
	cnt++;			
      }
    }
    if (cnt == strlen(words[i]) - 1) {
      for (int j = 0; j < strlen(words[i]) - 1; j++) {
	list[list_len][j] = words[i][j];
      }
      list[list_len][strlen(words[i]) - 1] = '\0';
      list_len++;
    }
  }

  for (int i = 0; i < list_len; i++) {
    printf("%s ", list[i]);
  }
  printf("\n");
}

/* Check if c is in word, and available. (Update available letters.) */
bool is_in(char c, char* word, bool* avail) {
  for (int i = 0; i < strlen(word); i++) {
    if ( (c == word[i]) && (avail[i]) ) {
      avail[i] = false;
      return true;
    }
  }
  return false;
}
