#!/usr/bin/env perl
=begin comment
-----------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-06-26
Challenge 223 Task 1 Count Primes ( Perl )
-----------------------------------------
=cut

use strict;
use warnings;
use feature 'say';
use ntheory qw/is_prime/;

my @input_n = (10,1,20);

for my $n (@input_n) {
    my $num = 0;
    my $cnt = 0;
    say "Input: \$n = $n";
    while ($num < $n){
        if (is_prime($num)) { $cnt++};
        $num++;
    }
    say "Output: $cnt\n";
}

=begin comment
-----------------------------------------
SAMPLE OUTPUT
perl .\CountPrimes.pl

Input: $n = 10
Output: 4

Input: $n = 1
Output: 0

Input: $n = 20
Output: 8
-----------------------------------------
=cut



