#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#define MAXLEN 1000

char *parse(char *s) {
  int left_ind = -1;
  int len = strlen(s);
  for (int i = 0; i < len; i++)
    if (s[i] == '[')
      left_ind = i;
  if (left_ind == -1)
    return s;
  char *o = malloc(MAXLEN);
  strcpy(o, s);
  while (left_ind != -1) {
    // Find last location of a starting bracket, store the substring to tmp and repeat it num times
    left_ind = -1;
    int olen = strlen(o);
    for (int i = 0; i < olen; i++)
      if (o[i] == '[')
	left_ind = i;

    if (left_ind != -1) {
      int right_ind = strstr(o + left_ind, "]") - o;
      int tmplen = right_ind - left_ind - 1;
      char *tmp = malloc(tmplen + 1);
      strncpy(tmp, o + left_ind + 1, tmplen);
      tmp[tmplen] = '\0';
      
      char *numb = malloc(4);	/* repetition number is 3 digits maximum */
      numb[0] = '0';
      numb[1] = '0';
      numb[2] = '0';
      numb[3] = '\0';
      int j = left_ind - 1;
      int numb_ind = 2;
      while (j >= 0) {
	if (o[j] >= '0' && o[j] <= '9') {
	  numb[numb_ind--] = o[j];
	  j--;
	} else {
	  break;
	}
      }
      j++;
      // j now contains the left index of a substring we want to remove, we stop at right_ind, replacing with fill
      int num = atoi(numb);
      free(numb);
      char *fill = malloc(MAXLEN);
      fill[0] = '\0';
      for (int i = 0; i < num; i++)
	strcat(fill, tmp);
      free(tmp);
      char *pre = malloc(MAXLEN);
      strncpy(pre, o, j);
      pre[j] = '\0';
      char *post = malloc(MAXLEN);
      strcpy(post, o + right_ind + 1);
      char *newo = calloc(MAXLEN, 1);
      strcat(newo, pre);
      strcat(newo, fill);
      strcat(newo, post);
      free(o);
      free(pre);
      free(fill);
      free(post);
      o = newo;
    }
  }
  return o;
}

void proc(char *s){
  printf("Input: $str = %s\n", s);
  printf("Output: %s\n", parse(s));
}

int main() {
  char *str = "2[3[a]]";
  proc(str);
  str = "10[a]";
  proc(str);
  str = "a2[b]c3[d]e";
  proc(str);
  str = "2[a2[b]c]";
  proc(str);
  str = "1[a]2[b3[c]]";
  proc(str);
}
