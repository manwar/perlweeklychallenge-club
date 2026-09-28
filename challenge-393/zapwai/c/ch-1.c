#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

void multiples(int *olen, char *o[*olen], int a, int b, int c, int num) {
  for (int k = 1; k <= num/c; k++) {
    o[*olen] = malloc(30);
    sprintf(o[(*olen)++], "%d %d %d", a*k, b*k, c*k);
  }
}

void proc(int num) {
  printf("Input: %d\n",num);
  char *o[3*num];
  int olen = 0;
  for (int m = 2; m < sqrt(num); m++) {
    for (int n = 1; n < m; n++) {
      if ((m % n == 0) && (n > 1)) continue;
      int c = m*m + n*n; // Euclid's Formula
      if (c > num) break;
      int a = m*m - n*n;
      int b = 2*m*n;
      multiples(&olen, o, a, b, c, num);
      multiples(&olen, o, b, a, c, num);
    }
  }

  /* unique entries only */
  char *out[3*num];
  int outlen = 0;
  bool bad = false;
  for (int i = 0; i < olen; i++) {
    bad = false;
    char *s = o[i];
    for (int j = 0; j < i; j++) {
      char *r = o[j];
      if (strcmp(s,r) == 0) {
	bad = true;
	break;
      }
    }
    if (!bad) {
      out[outlen] = malloc(30);
      strcpy(out[outlen++], s);
    }
  }
    
  printf("Output: %d\n", outlen);
  for (int i = 0; i < outlen - 1; i++) {
    printf("%s, ", out[i]);
    free(out[i]);
  }
  printf("%s\n", out[outlen-1]);
  free(out[outlen-1]);

  for (int i = 0; i < olen; i++)
    free(o[i]);
}

int main() {
  int num = 20;
  proc(num);
}
