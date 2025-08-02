#include <stdio.h>
#include "vec.h"

void proc(int myint) {
  printf("Input: %d\n", myint);
  int numb = -1;
  int current = 0;
  int prev = 0;
  int cnt = 0;
  vec *num = new_vec('i');
  int t = myint;
  while (t != 0) {
    int val = t % 10;
    push(num, &val);
    t = t / 10;
  }
  for (int i = 0; i < num->size; i++) {
    prev = current;
    current = num->data[i];
    if (prev == current) {
      cnt++;
    } else {
      if (cnt == 2) {
	numb = prev;
	break;
      } else {
	cnt = 0;
      }
    }
  }
  printf("Output: %d\n", numb);
}

int main() {
  int mynum= 123444567;
  proc(mynum);
  int mynum2 = 1233334;
  proc(mynum2);
  int mynum3 = 10020003;
  proc(mynum3);
}
