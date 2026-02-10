#include <stdio.h>
#include <string.h>

void proc(char *str, int width) {
  printf("Input: str = %s, width = %d\n", str, width);
  int diff = width - strlen(str);
  if (diff < 0) {
    printf("Error, length too short");
  } else {
    int left_len = (diff / 2);
    int right_len = diff - left_len;
    for (int i = 0; i < left_len; i++)
      printf("*");
    printf("%s", str);
    for (int i = 0; i < right_len; i++)
      printf("*");
    printf("\n");
  }
  
}

int main(){
  char *str = "Hi"; int width = 5;
  proc(str, width);
  char *str2 = "Code"; int width2 = 10;
  proc(str2, width2);
  char *str3 = "Hello"; int width3 = 9;
  proc(str3, width3);
  char *str4 = "Perl"; int width4 = 4;
  proc(str4, width4);
  char *str5 = "A"; int width5 = 7;
  proc(str5, width5);
  char *str6 = ""; int width6 = 5;
  proc(str6, width6);
}
