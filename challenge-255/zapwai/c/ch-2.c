#include <stdio.h>
const int M = 20; /* upper bound on number of words in the sentence */
void proc(char *p, char *wor, int plen, int worlen) {
  printf("Input: ");
  printf("s: %s ", p);
  printf("\n\tw: %s\n", wor);
  /* w is a list of strings, were splitting on ' ' */
  char w[M][20];
  int wlen[M] = {0};	 /* length of words in list */
  int skip[M] = {0};	 /* entries to skip bc they match wor */
  int freq[M] = {0};	 /* a cumulative count of each word */

  int entry = 0;
  int j = 0;
  /* copy words into w, skip punctuation */
  for (int i = 0; i < plen; i++) {
    if (p[i] == ' ') {
      wlen[entry] = j;
      entry++;
      j = 0;
      continue;
    } else if ( (p[i] < 65) || (p[i] > 122) ) {
      continue;
    } else {
      w[entry][j] = p[i];
      j++;
    }
  }
  wlen[entry] = j; /* entry is now the number of words - 1 */
  /* find which words to skip bc they match wor */
  for (int i = 0; i <= entry; i++) {
    int cnt = 0;
    for (int k = 0; k < wlen[i]; k++) {
      if (wor[k] == w[i][k]) {
	cnt++;
      }
    }
    if (cnt == worlen - 1) {
      skip[i] = 1;
    }
  }
  /* compute frequency of words , 0 for banned word */
  for (int i = 0; i <= entry; i++) {
    if (skip[i] == 1) { continue; }
    else { freq[i]++; }

    for (int lvl = 0; lvl < i; lvl++) {
      int cnt = 0;
      for (int k = 0; k < wlen[lvl]; k++) {      
	if (w[lvl][k] != w[i][k]) { goto nex;}
	else {cnt++;}
      }
      if (cnt == wlen[i]) {
	freq[i]++;
      }
    nex:
    }
  }
  int max = 0;
  int index = 0;
  for (int i = 0; i <= entry; i++) {
    if (max < freq[i]) {
      max = freq[i];
      index = i;
    }
  }
  printf("Output: ");  
  for (int k = 0; k < wlen[index]; k++) {
    printf("%c", w[index][k]);
  }
  printf("\n\n");
}

int main() {
  char p[] = "Joe hit a ball, the hit ball flew far after it was hit.";
  char w[] = "hit";
  int plen = sizeof(p) / sizeof(char);
  int wlen = sizeof(w) / sizeof(char);  
  char p2[] = "Perl and Raku belong to the same family. Perl is the most popular language in the weekly challenge.";
  char w2[] = "the";
  int plen2 = sizeof(p2) / sizeof(char);
  int wlen2 = sizeof(w2) / sizeof(char);    
  proc(p, w, plen, wlen);
  proc(p2, w2, plen2, wlen2);
}