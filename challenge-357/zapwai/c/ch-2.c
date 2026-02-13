#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <math.h>
#include <stdbool.h>

int main(int argc, char *argv[]) {
  if (argc == 1 || argc > 2)
    return 1;
  printf("Input: %s\n", argv[1]);
  int N = atoi(argv[1]);
  int list[N];
  for (int i = 1; i <= N; i++)
    list[i-1] = i;

  char orig_fraction[N*N][16];
  float orig_real[N*N];
  for (int i = 0; i < N; i++) {
    for (int j = 0; j < N; j++) {
      snprintf(orig_fraction[i*N+j], 16, "%d/%d", i+1, j+1);
      orig_real[i*N+j] = (float)(i+1)/ (float)(j+1);
    }
  }

  int bad[N*N];			/* indices of repeats */
  int badcnt = 0;
  for (int i = 0; i < N*N - 1; i++) {
    float fixed = orig_real[i];
    for (int j = i+1; j < N*N; j++) {
      float current = orig_real[j];
      if (fabs(current - fixed) < 1e-5) {
	bool already = false;
	for (int k = 0; k < badcnt; k++) {
	  if (bad[k] == j) {
	    already = true;
	    break;
	  }
	}
	if (!already) bad[badcnt++] = j;

      }
    }
  }

  char fraction[N*N][16]; /* fractions with repeats removed */
  float real[N*N];	  /* reals with repeats removed */
  int cnt = 0;
  for (int i = 0; i < N*N; i++) {
    bool flag = false;		/* flag if bad index */
    for (int j = 0; j < badcnt; j++) {
      if (bad[j] == i) {
	flag = true;
	break;
      }
    }
    if (!flag) {
      strcpy(fraction[cnt], orig_fraction[i]);
      real[cnt++] = orig_real[i];
    }
  }

  int swaps = 1;
  while (swaps != 0) {
    swaps = 0;
    for (int i = 0; i < cnt-1; i++) {
      if (real[i] > real[i+1]) {
	swaps++;
	float tmp = real[i];
	real[i] = real[i+1];
	real[i+1] = tmp;
	char *tmps = malloc(16);
	strcpy(tmps, fraction[i]);
	strcpy(fraction[i], fraction[i+1]);
	strcpy(fraction[i+1], tmps);
	free(tmps);
      }
    }
  }
  printf("Output: ");
  for (int i = 0; i < cnt; i++) {
    printf("%s ", fraction[i]);
  }
  printf("\n");
  return 0;
}
