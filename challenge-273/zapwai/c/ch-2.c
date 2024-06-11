#include <stdio.h>
#include <stdbool.h>
#include <string.h>

void proc(char* str) {
  printf( "Input: str = %s\n", str);
  bool ver = false;
  int bcnt = 0;
  for (int i = 0; i <= strlen(str); i++)
    if (str[i] == 'b')
      bcnt++;
  if (bcnt > 0) {
    ver = true;
    bool bflag = false;
    for (int i = 0; i <= strlen(str); i++) {
      char l = str[i];
      if ((l == 'a') && bflag) {
	ver = false;
	break;
      } else {
	if (l == 'b')
	  bflag = true;
      }
    }
  }
  printf( "Output: ");
  printf((ver) ? "true" : "false");
  printf("\n");
}

int main() {
  char* str = "aabb";
  proc(str);
  str = "abab";
  proc(str);
  str = "aaa";
  proc(str);
  str = "bbb";
  proc(str);
}

