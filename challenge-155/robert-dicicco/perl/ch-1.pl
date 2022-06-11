use strict;
use warnings;
use ntheory qw/pn_primorial is_prime/;
use List::Util qw/uniq/;

# Author: Robert DiCicco
# Date: 7-MAR-2022
# Challenge #155 Fortunate Numbers ( Perl )

my @out;  # array to hold final output
my $howmany = 8;

foreach (1..($howmany+1)) {
  my $p = pn_primorial($_);  # product of first n primes
  my $m = 1;
  my $i = 0;

  do {
    $m++;
    $i = $p + $m;
  } until ( is_prime($i));  # add m until we hit next prime

  push(@out, $m);    # save m to the output array
}

@out = sort { $a <=> $b } @out;   # sort the output array
@out = uniq(@out);     # only keep unique values

print "@out ";
print "\n";
