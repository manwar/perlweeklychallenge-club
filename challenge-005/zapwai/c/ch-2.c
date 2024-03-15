#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "005.h"

int strcompare(const void* a, const void* b) {
  const char* stra = *(const char**)a;
  const char* strb = *(const char**)b;
  return strcmp(stra, strb);
}

int main(int argc, char* argv[]) {
  char* dict[MAX_WORDS];
  int dict_length = 0;
  dictset(dict, &dict_length);

  char* alpha[dict_length];
  alphaset(alpha, dict_length, dict);

  qsort(alpha, dict_length, sizeof(char*), strcompare);

  /* Count number of anagrams */
  int flag = 0;
  int maxlen = 0;
  char* maxword = "";
  int cnt = 0;
  for (int i = 0; i < dict_length - 1; i++) {
    if (strlen(alpha[i]) < 4) {
      continue;
    }
    if (flag == 1) {
      if (strcmp(alpha[i], alpha[i+1]) != 0) {
	flag = 0;
	cnt++;
	if (maxlen < cnt) {
	  maxlen = cnt;
	  maxword = alpha[i];
	}
	cnt = 0;
      } else {
	cnt++;
      }
    } else {
      if (strcmp(alpha[i], alpha[i+1]) == 0) {
	flag = 1;
	cnt++;
      }
    }
  }

  printf("%d: %s\n", maxlen, maxword);
  
  for (int i = 0; i < dict_length; i++) {
    free(dict[i]);
    free(alpha[i]);
  }
  return 0;
}

