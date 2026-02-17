#include <stdio.h>
#include <string.h>
#include <stdbool.h>
#include <ctype.h>
#include <stdlib.h>

void proc(char *str[], int len) {
  printf("Input: ");
  
  int size[len];
  for (int i = 0; i < len; i ++) {
    printf("%s ", str[i]);
    bool flag = false;
    for (int j = 0; j < strlen(str[i]); j++) {
      if (isalpha(str[i][j]) != 0) {
	flag = true;
	break;
      }
    }
    if (flag) {
      size[i] = strlen(str[i]);
    } else {
      size[i] = atoi(str[i]);
    }
  }
  printf("\n");
  int max = 0;
  for (int i = 0; i < len; i++) {
    if (max < size[i])
      max = size[i];
  }
  printf("Output: %d\n", max);
}

int main(){
  char *str[3] = {"123", "45", "6"};
  proc(str, 3);

  char *str2[3] = {"abc", "de", "fghi"};
  proc(str2, 3);

  char *str3[3] = {"0012", "99", "a1b2c"};
  proc(str3, 3);

  char *str4[4] = {"x", "10", "xyz", "007"};
  proc(str4, 4);

  char *str5[3] = {"hello123", "2026", "perl"};
  proc(str5, 3);
}
