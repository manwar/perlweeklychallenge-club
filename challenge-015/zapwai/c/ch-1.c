#include <stdio.h>
#define N 100

void fill_weak_strong(int* primes, int prime_len, int* avg, int* weak, int* strong, int* other) {
  int j1 = 0, j2 = 0, j3 = 0;
  weak[0] = 3; j1++;
  for (int i = 1; i < prime_len - 1; i++) {
    if (primes[i] < avg[i]) {
      weak[j1] = primes[i];
      j1++;
    }
    else if (primes[i] > avg[i]) {
      strong[j2] = primes[i];
      j2++;
    }
    else {
      other[j3] = primes[i];
      j3++;
    }
  }
}

void fill_primes(int* primes, int* prime_len, int num) {
  primes[0] = 2;
  *prime_len = 1;
  int current = 2;
  while (*prime_len < num) {
    current++;
    int cnt = 0;
    for (int i = 0; i < *prime_len; i++) {
      int p = primes[i];
      if (current % p == 0)
	cnt++;
    }      
    if (cnt == 0) {
      primes[*prime_len] = current;
      (*prime_len)++;
    }
  }
}

void avg_primes(int* primes, int prime_len, int* avg) {
  avg[0] = 0;	/* First and last are garbage values */
  for (int i = 1; i < prime_len - 1; i++)
    avg[i] = (primes[i + 1] + primes[i - 1]) / 2;
  avg[prime_len - 1] = 0;
}

int main() {
  int primes[N] = {};
  int avg[N] = {};
  int prime_len = 0;
  fill_primes(primes, &prime_len, 60);
  avg_primes(primes, prime_len, avg);
  int weak[N] = {};
  int strong[N] = {};
  int other[N] = {};
  fill_weak_strong(primes, prime_len, avg, weak, strong, other);
  printf("Weak: ");
  for (int i = 0; i < 10; i++)
    printf("%d ", weak[i]);
  printf("\nStrong: ");
  for (int i = 0; i < 10; i++)
    printf("%d ", strong[i]);
  printf("\n");
}
