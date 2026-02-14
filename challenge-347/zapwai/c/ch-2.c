#include <stdio.h>
#include <string.h>
#include <ctype.h>

void proc(char *s) {
  printf("Input: %s\n", s);
  int len = strlen(s);
  char digit[len] = {};
  int dig_cnt = 0;
  for (int i = 0; i < len; i++) {
    if (isdigit(s[i])){
      digit[dig_cnt++] = s[i];
    }
  }
  printf("Output: ");
  if (dig_cnt == 4) {
    printf("%c%c-%c%c", digit[0], digit[1], digit[2], digit[3]);
  } else {
    if (dig_cnt % 3 == 1) { /* ends in two-two block */
      for (int i = 0; i < dig_cnt - 4; i++) {
	if (i != 0 && i % 3 == 0) printf("-");
	printf("%c", digit[i]);
      }
      for (int i = dig_cnt - 4; i < dig_cnt; i++) {
	if (i != 0 && i % 2 == 1) printf("-");
	printf("%c", digit[i]);
      }
    } else {			/* blocks of three OR ends in single block of two */
      for (int i = 0; i < dig_cnt; i++) {
	if (i != 0 && i % 3 == 0) printf("-");
	printf("%c", digit[i]);
      }
    }
  }  
  printf("\n");
}

int main() {
  char *str = "1-23-45-6";
  proc(str);
  str = "1234";
  proc(str);
  str = "12 345-6789";
  proc(str);
  str = "123 4567";
  proc(str);
  str = "123 456-78";
  proc(str);
  str = "123 456 789 1236";
  proc(str);
  str = "123 456 789 12";
  proc(str);
}
