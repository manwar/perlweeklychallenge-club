#include <stdio.h>
void proc (int L, int len, char s[L][len], char sep) {
  printf("Input: s = ");
  for (int i = 0; i < L; i++) {
    printf("%s ", s[i]);
  }
  printf("\nOutput: ");
  for (int i = 0; i < L; i++) {
    for (int j = 0; j < len; j++) {
      (s[i][j] == sep) ? printf(" ") : printf("%c", s[i][j]);
    }
    printf(" ");
  }
  printf("\n");
}
int main () {
  const int len = 30;
  int L = 3;
  char s[][len] = {"one.two.three", "four.five", "six"};
  char sep = '.';
  proc(L, len, s, sep);
  int L2 = 2;
  char s2[][len] = {"$perl$$", "$$raku$"};
  char sep2 = '$';
  proc(L2, len, s2, sep2);  
}