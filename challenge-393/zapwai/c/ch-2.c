#include <stdio.h>
#include <string.h>
#include <stdbool.h>
#define PRIMESIZE 10000

bool no_div(int n, int plen, int p[PRIMESIZE]) {
  for (int i = 0; i < plen; i++) {
    int prime = p[i];
    if (n % prime == 0) return false;
  }
  return true;
}

void fill(int *plen, int p[PRIMESIZE]) {
  for (int n = 2; n < PRIMESIZE; n++) {
    if (no_div(n, *plen, p)) {
      p[*plen] = n;
      (*plen)++;
    }
  }
}

void proc(char *s, int plen, int primes[PRIMESIZE]) {
  printf("Input: %s\n", s);
  int slen = strlen(s);
  int val = 0;
  for (int i = 0; i < slen; i++)
    val += s[i];
  int index = 0;
  for (int i = 0; i < plen; i++) {
    if (primes[i] < val) continue;
    index = i;
    break;
  }
  int pre = primes[index - 1];
  int post = primes[index];

  int adiff = val - pre;
  int bdiff = post - val;

  int out = (adiff < bdiff) ? adiff : bdiff;
  printf("Output: %d\n", out);
}

int main() {
  int plen = 0;
  int primes[PRIMESIZE] = {};
  fill(&plen, primes);
  char *s = "hello";
  proc(s, plen, primes);
  s = "football";
  proc(s, plen, primes);
  s = "a";
  proc(s, plen, primes);
  s = "challenge";
  proc(s, plen, primes);
  s = "perl";
  proc(s, plen, primes);
}
