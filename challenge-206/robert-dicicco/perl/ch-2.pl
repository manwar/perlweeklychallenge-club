#!/usr/bin/env perl
#---------------------------------------
# AUTHOR: Robert DiCicco
# DATE  : 2023-03-02
# Challenge 206 Array P:airings ( Perl )
#--------------------------------------
use strict;
use warnings;
use feature 'say';
use List::Util qw/min/;

my @arrs = ([1,2,3,4],[0,2,1,3]);
my @pairs = ([0,1,2,3], [0,2,1,3], [0,3,1,2]);
my $maxval = 0;

for my $arr (@arrs) {
    say "Input: \@array = [",@$arr,"]";
    for my $pr (@pairs) {
        my @a1 = @$pr;
        my $sum = @$arr[min(@a1[0..1])] + @$arr[min(@a1[2..3])];
        if ($sum > $maxval) {
            $maxval = $sum;
        }
    }
    print "Output: $maxval\n\n";
    $maxval = 0;
}

#---------------------------------------
# SAMPLE OUTPUT
# perl .\ArrayPairings.pl
# Input: @array = [1234]
# Output: 4

# Input: @array = [0213]
# Output: 2
#---------------------------------------


