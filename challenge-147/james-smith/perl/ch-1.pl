#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Time::HiRes qw(time);

$|=1;

## Finding left-truncated primes.

## Set up primes
my( $t0, $index, $N, $c, @primes ) = ( time, 0, @ARGV ? $ARGV[0] : 20, 5, 3 );
my @tprimes_current = (3,7);

printf "%6d\t%28d\t%15.6f\n", ++$index, $_, time - $t0 foreach 2,3,5,7;

## The 1-digit primes are 2, 3, 5 and 7.
## All 2-digit primes (that are truncated) end in either 3 or 7, so we use
## the array (3,7) as the starting list of truncated primes...
##
## To get the list of potential truncated primes of length (n+1) by
## looping through each of the primes of length (n) prefixed by the numbers
## 1 .. 9.
##
## We check to see if these are prime - by looking to see if they have
## prime factors < sqrt(n)
##
## (We may need to update the list of primes {less than sqrt(n)}) before
## the check)
##
## We continue around this loop looking at longer and longer primes,
## until we have collected enough primes OR @tprimes_current is empty

while(1) {
  last unless @tprimes_current; ## Exit if there are no current l-trunc primes
                                ## We are at the end of the list...

  my @tprimes_new = ();

  foreach my $first ( 1..9 ) {
    B: foreach my $base ( @tprimes_current ) {
      my $p = $first.$base;

      ## Update list of primes...
      foreach( ;$primes[-1]*$primes[-1]<$p;$c+=2) {
        ($_*$_>$c)?(push(@primes,$c),last):$c%$_||last for @primes;
      }

      ## check if $p is composite;
      $p%$_||next B foreach @primes;

      ## If not we add the prime to the list of primes of length `n+1`

      push @tprimes_new, $p;

      ## And output the index/prime/and time taken..
      printf "%6d\t%28d\t%15.6f\n", ++$index, $p, time - $t0;
      exit if $index >= $N; ## Stop if we have got to limit set
    }
  }
  ## We use new list we generated as the current list for the
  ## next loop.
  @tprimes_current = @tprimes_new;
}

## Times taken to get to certain truncated primes
## Note there are 4260 left-truncated primes in total.
##
## The largest one is 357,686,312,646,216,567,629,137
##
## We know this number is finite as there are no
## 25 digit left-truncated primes.
##
## Below are times for the code to generate the
## given number of primes [and the value of the
## last one] you will note that the large indexes
## the time required per step increases greatly
## I believe this is mainly in computing all the
## possible prime factors to look for composites


## Index Running time          Value of prime..
##    20    0.0001 sec                        197
##   100    0.0005 sec                      5,167
## ----------------------------------------------
##   500    0.0045 sec                    543,853
## 1,000    0.0173 sec                  8,391,283
## 1,500    0.0477 sec                 79,962,683
## 2,000    0.1246 sec                736,275,167
## 2,500    0.3298 sec              6,946,986,197
## 3,000    0.9487 sec             75,315,729,173
## 3,500    3.9416 sec          1,837,839,918,353
## 4,000   62.3637 sec        313,231,816,543,853
## ----------------------------------------------
## 4,100  3 min 54 sec      2,696,154,867,812,347
## 4,200        41 min     94,669,684,516,387,853
## ----------------------------------------------
## 4,210   1 hr 46 min    396,334,245,663,786,197
## 4,220   2 hr 36 min    686,315,421,273,233,617
## ----------------------------------------------
## 4,229   3 hr 59 min  1,276,812,967,623,946,997
## 4,230   7 hr 48 min  3,396,334,245,663,786,197
## 4,231   7 hr 57 min  3,484,957,213,536,676,883
## 4,232   9 hr 46 min  4,686,798,799,354,632,647

## Length   # of length   # cumulative
##      1             4              4
##      2            11             15
##      3            39             54
##      4            99            153
##      5           192            345
##      6           326            671
##      7           429           1100
##      8           521           1621
##      9           545           2166
##     10           517           2683
##     11           448           3131
##     12           354           3485
##     13           276           3761
##     14           212           3973
##     15           117           4090
##     16            72           4162
##     17            42           4204
##     18            24           4228
##     19
