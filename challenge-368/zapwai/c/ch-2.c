#include <stdio.h>
#include <math.h>
#include <stdbool.h>
#include <stdlib.h>

#define SIZE 1000000
#define FACTORSIZE 50

int main(int argc, char *argv[]) {
  if (argc < 2) {
    printf("Usage: %s <number>\n", argv[0]);
    return 1;
  }
  int primes[1000] = {};
  int primes_len = 0;
  primes[primes_len++] = 2;
  for (int i = 3; i < sqrt(SIZE) + 1; i++) {
    bool flag = true;		/* number is prime if this remains true */
    for (int j = 0; j < primes_len; j++) {
      if (i % primes[j] == 0) {
	flag = false;
	break;
      }
    }
    if (flag)
      primes[primes_len++] = i;
  }
  int num = atoi(argv[1]);
  int factors[FACTORSIZE] = {};
  int f_len = 0;
  for (int j = 0; j < primes_len; j++) {
    while (num % primes[j] == 0) {
      factors[f_len++] = primes[j];
      num /= primes[j];
    }
    if (num == 1) break;
  }
  if (num > 1)
    factors[f_len++] = num;
  printf("Factors: ");
  for (int i = 0; i < f_len; i++) 
    printf("%d ", factors[i]);
  int unique[f_len] = {};
  int distinct = 0;
  unique[distinct++] = factors[0];
  for (int i = 1; i < f_len; i++) {
    bool flag = true;
    for (int j = 0; j < distinct; j++) {
      if (factors[i] == unique[j]) flag = false;
    }
    if (flag) unique[distinct++] = factors[i];
  }
  printf("(%d distinct)", distinct);
  printf("\n");
}
