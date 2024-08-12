#include <stdio.h>
#include <string.h>
#include <ctype.h>
char lc(char c) {
  return tolower(c);
}
void proc(char* str) {
  printf( "Input: %s\n", str);
  char* let = str;
  char prev = '0';
  char curr;
  int cnt = -1;
  for (int i = 0; i < strlen(str); i++) {
      curr = let[i];
      if (lc(prev) != lc(curr))
	cnt++;
      prev = curr;
    }
  printf("Output: %d\n", cnt);
}
int main() {
  char* str = "pPeERrLl";
  proc(str);
  char* str2 = "rRr";
  proc(str2);
  char* str3 = "GoO";
  proc(str3);
}
