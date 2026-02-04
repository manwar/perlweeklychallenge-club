#include <stdio.h>
#include <string.h>
#include <stdlib.h>

char *strip(int wordlen, char word[]) {
  
  int list[wordlen];		/* list of bad indices */
  int listlen = 0;
  int flag = 0;			/* avoid mistaken pairs e.g. aaaf -> af (not f)*/
  for (int i = 0; i < wordlen - 2; i++) {
    if (flag == 1) {
      flag = 0;
      continue;
    }
    if (word[i] == word[i+1]) {
      list[listlen++] = i;
      flag = 1;
    }
  }
  
  char outword[wordlen];
  int outlen = 0;
  flag = 0;
  for (int i = 0; i < wordlen; i++) { 
    /* If i is in list, skip i and i+1, needed a counter and a flag for that */
    int list_counter = 0;
    for (int j = 0; j < listlen; j++)
      if (list[j] != i)
	list_counter++;

    if (flag == 0) {
      if (list_counter == listlen) {
	outword[outlen++] = word[i];
      } else {
	flag = 1;
      }
    } else {
      flag = 0;
    }
  }
  char *return_word;
  return_word = malloc(50*sizeof(char));
  strcpy(return_word, outword);
  return return_word;
}

void proc(int wordlen, char word[]) {
  printf("Input: %s\n", word);
  char *outword = strip(wordlen, word);
  int loop = 0;
  do { 
    int len = strlen(outword);
    char newword[len+1];
    memcpy(newword,outword,len+1);
    outword = strip(len+1, newword);
    loop++;
  } while (loop < wordlen);	/* very lazy */
  
  printf("Output: %s\n", outword);
}

int main() {
  char word[] = "aabbccdd";
  proc(sizeof(word), word);
  char word2[] = "abccba";
  proc(sizeof(word2), word2);
  char word3[] = "abcdef";
  proc(sizeof(word3), word3);
  char word4[] = "aabbaeaccdd";
  proc(sizeof(word4), word4);
  char word5[] = "mississippi";
  proc(sizeof(word5), word5);
}
