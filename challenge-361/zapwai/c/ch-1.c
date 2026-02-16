#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

#define MAX 100			/* max input */
#define TEN 10			/* number of possible summands */

bool is_fibo(int n, int *fibo, size_t fibo_len) {
  for (int i = 0; i < fibo_len; i++) {
    if (fibo[i] == n)
      return true;
  }
  return false;
}

int *list_terms(int n, int *fibo, size_t fibo_len) {
  if (is_fibo(n, fibo, fibo_len)) {
    int *terms = malloc(2*sizeof(int));
    terms[0] = n;
    terms[1] = 0;
    return terms;
  } else {
    int max = 0;
    for (int i = 0; i < fibo_len; i++) {
      if (n < fibo[i]) {
	break;
      } else {
	max = fibo[i];
      }
    }
  
    int *terms = malloc(TEN*sizeof(int));
    int diff = n - max;
    
    int *t = list_terms(diff, fibo, fibo_len);
    int term_len = 0;
    do {
      terms[term_len++] = t[term_len];
    } while (t[term_len] != 0);

    free(t);
    terms[term_len++] = max;
    
    terms[term_len] = 0;	/* Last entry of list is a zero */
    return terms;
  }
}

void proc(int num, int *fibo, size_t fibo_len) {
  printf("Input: int = %d\n", num);
  if (is_fibo(num, fibo, fibo_len)) {
    printf("Output: %d\n", num);
  } else {
    printf("Output: ");
    int *terms = list_terms(num, fibo, fibo_len);
    int i = 0;
    do {
      printf("%d ", terms[i++]);
    } while (terms[i] != 0);
    printf("\n");
    free(terms);
  }
}

int main() {
  int *fibo = malloc(MAX*sizeof(int));
  size_t fibo_len = 0;
  fibo[fibo_len++] = 1;
  fibo[fibo_len++] = 1;
  while (fibo[fibo_len] < MAX) {
    fibo[fibo_len++] = fibo[fibo_len - 1] + fibo[fibo_len - 2];
  }

  int num = 4;
  proc(num, fibo, fibo_len);
  
  num = 12;
  proc(num, fibo, fibo_len);
  
  num = 20;
  proc(num, fibo, fibo_len);

  num = 96;
  proc(num, fibo, fibo_len);

  num = 100;
  proc(num, fibo, fibo_len);

  free(fibo);
  return 0;
}
