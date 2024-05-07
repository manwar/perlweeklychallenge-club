#include <stdio.h>
#include <string.h>

void proc(char* stringy, int widths[]) {
  printf("Input: string = %s\n", stringy);
  int pixwidth = 100;
  int width = pixwidth;
  int lines = 1;
  for (int i = 0; i < strlen(stringy); i++) {
    int w = widths[stringy[i]-97];
    if (width - w < 0) {
      lines++;
      width = pixwidth;
    }
    width -= w;
  }
  printf("Output: %d, %d\n", lines, pixwidth - width);
}

int main() {
  char* stringy = "abcdefghijklmnopqrstuvwxyz";
  int widths[] = {10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10};
  proc(stringy, widths);
  char* stringy2 = "bbbcccdddaaa";
  int widths2[] = {4,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10};
  proc(stringy2, widths2);
}
