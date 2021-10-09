# Perl Weekly Challenge #133

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-133/james-smith/perl

# Task 1 - Integer Square Root

***You are given a positive integer `$N`. Write a script to calculate the integer square root of the given number.***

## The solution

We implement Newton's formulae to compute the integer square root.. This is the compact version.

```perl
sub find_root {
  my( $x, $y ) = ( my $n = shift ) >> 1;             ## $x is half $n rounded down...
  return $n unless $x;                               ## Return $n if it is <2 (i.e. 0 or 1)
  $x = $y while ( $y = ( $x + $n / $x ) >> 1 ) < $x; ## The crux - the next no is 1/2 of $x & $n/$x
  return $x;                                         ## Return value
}
```

# Task 2 - Smith Numbers

***Write a script to generate first 10 Smith Numbers in base 10.***

## Solution

We break the logic up into chunks and implement those in separate function. As we look at each
prime in turn we can effectively create a sieve to get the prime factors.

Here is the main code.
 * We check to see if the sum of digits is the same as the sum of primefactor digits {and that it is not prime}
 * We add this to the list if it is the case
 * Return when we have `$C` (`10`) in this case...
```perl
sub smith_numbers {
  my ( $C, $n, @sn ) = (shift,3);
  ( sum_digits( $n ) - sum map { sum_digits $_ } prime_factors( $n ) ) ||
  ( push @sn, $n                                                     ) &&
  ( @sn == $C                                                        ) &&
  ( return @sn                                                       ) while $n++;
}
```

And the support functions:
 * `sum` - Just sum an array;
 * `sum_digits` - Sum digits of number,
   We cache the digit sum for each number in `%ds`;
 * `prime_factors` - for a prime returns nothing, for a composite returns the factors,
   We keep a list of primes `@primes`, and also the prime factors for each composite `%comp`.
   **Note:** We don't need to continue with primes bigger than `sqrt($N)` so short cut the loop.

```perl
sub sum        { my $t = 0; $t+=$_ foreach @_; $t;          }

sub sum_digits { return $ds{$_[0]} ||= sum split //, $_[0]; }

sub prime_factors {
  my $N = shift;
  ( $N % $_) ? ( ( $N < $_ * $_ ) && last )
             : ( return $sum_pf[$N] = $sum_pf[$N/$_] + $sum_pf[$_] )  foreach @primes;
  $sum_pf[$N] = cl_sum_digits $N;
  push @primes, $N;
  return 0;
}
```

## Performance

A slight modification to the code ( to compute Smith Numbers < N ) computes the 29,928 Smith numbers less than 1 million in about 3.3 seconds, and for 10,000,000 about 45 seconds. For large N the script falls over with out-of-memory errors.

## Re-write in C

The algorithm does lend itself to rewriting in a lower level language - it doesn't use any nice features of Perl except for the "auto-sizing" of arrays - no hashes, complex IO etc.

So here is my first C programme for probably 30 years!

### Timings for C vs perl

|     Max value | Count      | Time C  | Time perl |
| ------------: | ---------: | ------: | --------: |
|           100 |          6 |   0.00s |     0.01s |
|         1,000 |         49 |   0.00s |     0.01s |
|        10,000 |        376 |   0.00s |     0.03s |
|       100,000 |      3,924 |   0.01s |     0.26s |
|     1,000,000 |     29,928 |   0.07s |     3.25s |
|    10,000,000 |    278,411 |   1.18s |    45.38s |
|   100,000,000 |  2,632,758 |  23.65s |    *fail* |
| 1,000,000,000 | 25,154,060 | 514.17s |    *fail* |

This is the limit for the algorithm (would need 20+ Gbytes for the 10 billion case)

### The C code

```c
#include <stdio.h>

// Compute all Smith Numbers below MAX_N

// Use guess that PSIZE should approximately 1.1 * PFSIZE / ln(PFSIZE)

// 10^6
   #define MAX_N   1000000
   #define PSIZE   42000        // Have to guess this!
// 10^7
// #define MAX_N   10000000
// #define PSIZE   400000       // Have to guess this!
// 10^8
// #define MAX_N   100000000
// #define PSIZE   3200000      // Have to guess this!
// 10^9
// #define MAX_N   1000000000
// #define PSIZE   28000000     // Have to guess this!

#define PFSIZE (MAX_N/2)

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
    primes[ prime_index++ ] = n;
  }
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
```

**Notes:** In this version we use an optimisation - we know that we will never need to use factorisations or primes greater than `MAX_N/2` so we don't store/cache these.

