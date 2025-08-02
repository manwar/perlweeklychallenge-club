#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#define MAX_PRIME_VALUE 15000

int* fill_primes(int* primes_length) {
  int* primes = malloc(MAX_PRIME_VALUE * sizeof(int));
  primes[0] = 2;
  for (int i = 3; i < MAX_PRIME_VALUE; i++) {
    int cnt = 0;
    for (int j = 0; j < *primes_length; j++)
      if (i % primes[j] == 0)
	cnt++;
    if (cnt == 0) {
      primes[*primes_length] = i;
      (*primes_length)++;
    }
  }
  return primes;
}

bool is_prime(int num, int* primes, int primes_length) {
  for (int i = 0; i < primes_length; i++) {
    if (primes[i] < num) {
      if (num % primes[i] == 0) {
	return false;
      }
    }
    else {
      break;
    }
  }
  return true;
}

int primorial(int n, int* primes) {
  int p = 1;
  while (n > 0) {
    n--;
    p *= primes[n];
  }
  return p;
}

int euclid(int n, int* primes) {
  return 1 + primorial(n, primes);
}

int main() {
  int primes_length = 1;
  int* primes = fill_primes(&primes_length);
  for (int i = 0; i < 8; i++) {
    int x = euclid(i, primes);
    if (!is_prime(x, primes, primes_length)) {
      printf("%d\n", x);
      break;
    }
  }
  
  free(primes);
}
