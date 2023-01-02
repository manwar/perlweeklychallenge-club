#!/usr/bin/env perl

=begin

AUTHOR: Robert DiCicco

DATE  : 2023-01-02

Challenge 198 Prime Count ( Perl )

=cut

use strict;

use warnings;

use feature qw/say/;

use ntheory qw/is_prime/;

 

my @arr = (10,15,1,25);

 

for my $x (0..scalar(@arr)-1) {

                my $cnt = 0;

                print "Input: \$n = $arr[$x]\n"; # find primes less than @arr[$x]

                for my $n (0..$arr[$x]){

                                if(is_prime($n)) {

                                                $cnt++;

                                }

                }

                print "Output: $cnt\n\n";

}

 

=begin

perl .\PrimeCount.pl

Input: $n = 10

Output: 4

 

Input: $n = 15

Output: 6

 

Input: $n = 1

Output: 0

 

Input: $n = 25

Output: 9

=cut
