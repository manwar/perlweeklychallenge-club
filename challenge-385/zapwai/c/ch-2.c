#include <stdio.h>
#include <string.h>

void proc(char *str) {
  printf("Input: str = %s\n", str);
  char buffer[200];
  int buffer_len = 0;
  int cnt = 0;
  int len = strlen(str);
  for (int i = 0; i < len; i++) {
    char c = str[i];
      if (cnt == 0) {
	if (c == '(') {
	  cnt++;
	} else {
	  printf("Invalid Input!\n");
	  return;
	}
      } else {
	if (c == ')') cnt--;
	if (cnt == 0) continue;
	if (c == '(') cnt++;
	buffer[buffer_len++] = c;
      }
    }
  printf("Output: ");
  for (int i = 0; i < buffer_len; i++)
    printf("%c", buffer[i]);
  printf("\n");
}

int main() {
  char *str = "()()()";
  proc(str);

  str = "(((())))";
  proc(str);

  str = "(()())(())";
  proc(str);

  str = "()((()))()";
  proc(str);

  str = "(()(()))(()())";
  proc(str);
}
