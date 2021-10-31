#!/usr/bin/perl
# The Weekly Challenge 136
#  Task 2 Fibonacci Sequence
#  ( #077 Task 1 Fibonacci Sum )
# Usage: ch-2.pl $N

# implement http://www-igm.univ-mlv.fr/~berstel/
#           Articles/2001ExerciceAldo.pdf
# Author:J. Berstel
# title: An Exercise on Fibonacci Representations, 
# RAIRO/Informatique Theorique, Vol. 35, No 6, 2001

# link from https://oeis.org/A000119

use v5.12.0;
use warnings;
use Test::More tests => 7;
use List::Util qw/reduce/;

my $BIGNUM = $ARGV[1] || 102_334_155; # Fib_39 
my @FIBSEQ = (1, 1);
generate_up_to_BIGNUM($BIGNUM);

say num_of_fib_repr($ARGV[0]) if defined($ARGV[0]);



sub num_of_fib_repr {
    my $num = $_[0];
    my @zff = zeckendorff_index($num)->@*; 
    push @zff, 0;
    my @arr = map {  $zff[$_] - $zff[$_+1] - 1 } 0..$#zff-1;
    my $matrix = reduce {multi_sq($a,$b)} map {mat($_)} @arr;
    return $matrix->[0][0] + $matrix->[1][0];
}



sub mat {
    my $d = $_[0];
    return [ [1, 1], [ int($d/2), int(($d+1)/2) ] ];
}



sub multi_sq {
    my $mat0 = $_[0];
    my $mat1 = $_[1];
    return [
      [
        $mat0->[0][0] * $mat1->[0][0] + $mat0->[0][1] * $mat1->[1][0], 
        $mat0->[0][0] * $mat1->[0][1] + $mat0->[0][1] * $mat1->[1][1] 
      ],
      [
        $mat0->[1][0] * $mat1->[0][0] + $mat0->[1][1] * $mat1->[1][0], 
        $mat0->[1][0] * $mat1->[0][1] + $mat0->[1][1] * $mat1->[1][1] 
      ]
    ]
}



sub zeckendorff_index {
    my $num = $_[0];
    my @arr = ();
    my $s = get_largest_fib_ind($num);
    while ($num != 0) {
        if ($num >= $FIBSEQ[$s]) {
            $num = $num - $FIBSEQ[$s];
            push @arr, $s;
        }
        $s--;
    }
    return [@arr];
}



sub get_largest_fib_ind {
    my $num = $_[0];
    my $i = 1;
    while ($num > $FIBSEQ[$i]) {
        $i++;
    }
    return $i;
}



sub generate_up_to_BIGNUM {
    my $r = 1;
    while ($BIGNUM > $FIBSEQ[$r]) {
        $FIBSEQ[$r+1] = $FIBSEQ[$r]+$FIBSEQ[$r-1];
        $r++;
    }
}




ok num_of_fib_repr(1) == 1, "test case: N=1";
ok num_of_fib_repr(2) == 1, "test case: N=2";
ok num_of_fib_repr(41) == 2, "test case: N=41";
ok num_of_fib_repr(45) == 6, "test case: N=45";
ok num_of_fib_repr(54) == 1, "test case: N=54";
ok num_of_fib_repr(105) == 10, "test case: N=105";
ok num_of_fib_repr(113) == 10, "test case: N=113";
