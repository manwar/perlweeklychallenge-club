#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "vec.h"

void proc(char* s) {
  printf( "Input: %s\n", s);
  vec *digit = new_vec('i');
  for (int i = 0; i < strlen(s); i++) {
    if (s[i] == ' ')
      continue;
    int q = s[i] - '0';
    push(digit, &q);
  }
  int payload = *(int*) pop(digit);
  reverse(digit);
  int sum = 0;
  for (int i = 0; i < digit->size; i++) {
    if (i % 2 == 0) {
      int x = 2*digit->data[i];
      if (x > 9) {
	int a = x / 10;
	int b = x % 10;
	sum += a + b;
      } else {
	sum += x;
      }
    } else {
      sum += digit->data[i];
    }
  }
  char* ans = "false";
  if ((sum + payload) % 10 == 0) {ans = "true";}
  printf( "Output: %s\n", ans);
}

int main() {
  char* s = "17893729974";
  proc(s);
  char* s2 = "4137 8947 1175 5904";
  proc(s2);
  char* s3 = "4137 8974 1175 5904";
  proc(s3);
}
