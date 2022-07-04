#!perl.exe

use strict;
use warnings;
use ntheory qw /is_prime divisors/;
use Math::Combinatorics;

# AUTHOR: Robert DiCicco
# DATE: 2022-07-04
# Challange 172 Prime Partition ( Perl )

my @arr = ();             # array to hold divisors
my $m = $ARGV[0];         # number to test
my $n = $ARGV[1];         # how many factors to sum

sub CreateCombinations {
   my $combinat = Math::Combinatorics->new(count => $n,
                                        data => [@arr],
                                       );

    while(my @combo = $combinat->next_combination){       # create combinations of $n size
      @combo = sort { $a <=> $b } @combo;                   # sort, just for appearances
      my $sum = eval join '+', @combo;                      # sum them

      if($sum == $m){                                       # print if sum = $m
         print join(' ', @combo)."\n";
      }

    }
}

 for(my $p = 1; $p < $m; $p++) {

   if (is_prime($p)) { push(@arr, $p) }

 }

print("\$m = $m; \$n = $n\n");

CreateCombinations();
