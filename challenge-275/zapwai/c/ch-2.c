#include <stdio.h>
#include <string.h>
#define MAX 50

char shifty(char c, int d) {
  char alph[] = "abcdefghijklmnopqrstuvwxyz";
  int ind = (int) (strchr(alph, c) - alph);
  return alph[d + ind];
}

void proc(char stringy[]) {
  printf("Input: str = %s\n", stringy);
  char lets[MAX];
  int letslen = 0;
  char puts[MAX];
  int putslen = 0;
  for (int i = 0; i < strlen(stringy); i++) {
    if (i % 2 == 0) {
      char let = stringy[i];
      lets[letslen++] = let;
    } else {
      char put = shifty(lets[letslen - 1], stringy[i] - '0');
      puts[putslen++] = put;
    }
  }
  printf("Output: ");
  for (int j = 0; j < strlen(stringy)/2; j++)
    printf("%c%c", lets[j], puts[j]); 
  if ((strlen(stringy) % 2 == 1))
    printf("%c", lets[letslen - 1]);
  printf("\n");
}

int main() {
  char stringy[] = "a1c1e1";
  proc(stringy);
  char stringy2[] = "a1b2c3d4";
  proc(stringy2);
  char stringy3[] = "b2b";
  proc(stringy3);
}
