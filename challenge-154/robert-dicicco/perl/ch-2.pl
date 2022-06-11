#!perl.exe

use strict;
use warnings;
use ntheory qw/is_prime/;
use List::MoreUtils qw/uniq/;
use feature qw/say/;

# Author: Robert DiCicco
# Date: 28-FEB-2022
# Challenge #154 Padovan Prime ( Perl )

### Write a script to compute first 10 distinct Padovan Primes.

### Expected Output

### 2, 3, 5, 7, 37, 151, 3329, 23833, 13091204281, 3093215881333057

###

my @nums = (1,1,1);
my @out = ();
my $count = 10;

while ( $count >= 0 ) {
  my $len = scalar @nums;
  my $padnum = $nums[$len-2] + $nums[$len-3];
  push @nums, $padnum;

  if(is_prime($padnum)){
    push @out, $padnum;
    $count--;
  }
}

@out = uniq(@out);
print "@out ";
print "\n";
