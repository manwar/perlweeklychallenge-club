#include <stdio.h>

// Compute all Smith Numbers below MAX_N
#define MAX_N 1000000
#define PFSIZE (MAX_N/2)
#define PSIZE  100000     // Have to guess this!

// Set up arrays 
int sum_pf[ PFSIZE+1 ], primes[ PSIZE ], prime_index = 0;

// Compute sum of digits - unlike Perl we can't use split
// so we use repeated modulus/divide by 10..

int sum_digits(int n) {
  int total = 0;
  do { total += n%10; } while( n /= 10 );
  return total;
}

// Get the sum of prime factors - 
// as we build this in order we only need to find a 
// factorisation then we just add together the
// digit sum of the two factors (Here for speed we
// know one will be prime.
// We go through all primes we have until prime^2
// is greater than the number itself.
//
// To make the last bit easier IF we have a prime
// we return 0 as not composite...
//
// Note to save memory we only store the sum if 
// n < MAX_N/2 as we won't need it again (can't
// be a factor of a larger number less than MAX_N

int sum_prime_factors( int n ) {
  int p;
  for(int i=0; i< prime_index; i++ ) {
    p = primes[i];
    if( !(n % p) ) {
      if( n <= PFSIZE ) {
        return sum_pf[n] = sum_pf[n/p] + sum_pf[p];
      } else {
        return sum_pf[ n/p ] + sum_pf[ p ];
      }
    }
    if( n < p*p  ) { break; }
  }
  if( n <= PFSIZE ) {
    sum_pf[ n             ] = sum_digits(n);
  }
  primes[ prime_index++ ] = n;
  return 0;
}

// Main is simple just loop and search, printing out
// Smith numbers
int main() {
  int count = 0, n = 1;
  while( n++ <= MAX_N ) {
    if( sum_digits(n) == sum_prime_factors(n) ) {
      printf( "%11d\n", n );
    }
  }
}

