#include <stdio.h>
#include "vec.h"
const  int N = 1000;

int mypow(int b, int p) {
  int x = 1;
  for (int i = 0; i < p; i++) {
    x *= b;
    if (x > N) {		/* prevent overflow */
      return 0;
    }
  }

  return x;
}

int main() {
  vec *v;
  init_vec(v);
  for (int i = 0; i < 5; i++) {
    for (int j = 0; j < 32; j++) {
      for (int k = 0; k < 22; k++) {
	int y = mypow(2,i) * mypow(3,j) * mypow(5,k);
	if (y == 0) {
	  continue;
	}
	if (y <= N) {
	  push(v, y);
	}
      }
    }
  }
  sort(v);
  display(v);
  destroy_vec(v);
  return 0;
}
