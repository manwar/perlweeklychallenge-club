#include <stdio.h>
#include <math.h>
#include <string.h>
#include <stdlib.h>

char* alph = "0123456789abcdefghijklmnopqrstuvwxy";

int myIndex (char* s, char l) {
  for (int i = 0; i < strlen(s); i++) {
    if (s[i] == l) { return i; }
  }
  return -1;
}

char* to35(int num) {
  int q = num;
  char* s = malloc( 2 * sizeof(char) );
  
  while (q > 0) {
    int r = q % 35;
    q = q / 35;
    char newone[2] = {alph[r], '\0'};
    char* temp = malloc( (strlen(s) + 2) * sizeof(char));
    strcpy(temp, newone);
    strcat(temp, s);
    free(s);
    s = temp;
  }
  return s;
}

int to10(char* s, int len) {
  int n = len - 1;
  int sum = 0;
  for (int i = 0; i < len; i++) {
    int fn = myIndex( alph, s[i] );
    sum += pow(35, n) * fn;
    n--;
  }
  return sum;
}

int main () {
  printf("Input: (base-10) 100\nOutput: %s\n", to35(100));
  printf("Input: (base-35) 2u\nOutput: %d\n", to10("2u", 2));
}
