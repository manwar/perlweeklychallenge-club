#include <stdio.h>
#include <string.h>
#include <stdbool.h>
#include <math.h>

void proc(char *s, int size, char filler) {
  printf("Input: string = %s, size = %d, filler = %c\n", s, size, filler);
  int len = strlen(s);
  int k = len / size;
  if (len % size != 0) k++;
  int r = (len % size == 0) ? 0 : size - (len % size);
  printf("Output: ");
  bool broken = false;
  for (int i = 0; i < k; i++) {
    for (int j = i*size; j < (i+1)*size; j++) {
      if (j >= len) {
	broken = true;
	break;
      }
      printf("%c", s[j]);
    }
    if (!broken) printf(" ");
  }
  for (int i = 0; i < r; i++)
    printf("%c", filler);
  printf("\n");
}

int main() {
  char *s = "RakuPerl";
  int size = 4;
  char filler = '*';
  proc(s, size, filler);
  s = "Python"; size = 5; filler = '0';
  proc(s, size, filler);
  s = "12345"; size = 3; filler = 'x';
  proc(s, size, filler);
  s = "HelloWorld"; size = 3; filler = '_';
  proc(s, size, filler);
  s = "AI"; size = 5; filler = '!';
  proc(s, size, filler);
}
