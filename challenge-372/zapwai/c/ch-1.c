#include <stdio.h>
#include <string.h>

void proc(char *str) {
  char s[256];
  strncpy(s, str, 255);
  s[255] = '\0';
  printf("Input : \"%s\"\n", s);
  int space_cnt = 0;
  int i = 0;
  do {
    char letter = s[i++];
    if (letter == ' ') space_cnt++;
  } while (i < strlen(s));

  char words[20][50];
  int words_len = 0;
  char *tok = strtok(s, " \t\n\r");
  while (tok != NULL && words_len < 20) {
    strcpy(words[words_len], tok);
    words[words_len][49] = '\0';
    words_len++;
    tok = strtok(NULL, " \t\n\r");
  }

  int k = 0, r = 0;
  if (words_len == 1) {
    r = space_cnt;
  } else {
    k = space_cnt / (words_len - 1);
    r = space_cnt % (words_len - 1);
  }
  char out[256];
  char *p = out;
  for (int i = 0; i < words_len; i++){
    int j = 0;
    while (words[i][j]) {
      *p++ = words[i][j++];
    }
    if (i < words_len - 1){
      for (int q = 0; q < k; q++) *p++ = ' ';
    } else {
      while (r > 0) {
	*p++ = ' ';
	r--;
      }
    }
  }
  *p = '\0';
  printf("Output: \"%s\"\n", out);
}

int main() {
  char *s = "  challenge  ";
  proc(s);
  s = "coding  is  fun";
  proc(s);
  s = "a b c  d";
  proc(s);
  s = "  team      pwc  ";
  proc(s);
  s = "   the  weekly  challenge  ";
  proc(s);
}
