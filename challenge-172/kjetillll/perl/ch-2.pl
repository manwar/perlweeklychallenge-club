#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-172/
# perl ch-2.pl 13 5 9 7 15            #run with unsorted list of numbers to their five-number summary
# perl ch-2.pl                        #run without args to run tests

use strict; use warnings; use Carp; use Test::More;

if( @ARGV ){                          #if there are command line arguments
    my @f = five(@ARGV);
    my @info = qw(input min q1 median q3 max);
    printf "%-10s %s\n", shift(@info), $_ for "@ARGV", @f;
}
else {
    do_tests();
}


sub five {                            #method 1 in https://en.wikipedia.org/wiki/Quartile
    @_==0 and croak "five: got no args";
    @_==1 and return (@_) x 5;        #same number five times if just one arg
    my @s    = sort { $a <=> $b } @_; #input sorted
    my $n    = @s;                    #number of elements
    my $q1   = int($n/2-1)/2;         #index of q1, can be .5 
    my $q3   = $n-1-$q1;              #index of q3
    my $odd  = $n%2;                  #true if n is odd, odd number of elements overall
    my $oddh = $n%4>1;                #true if the halves have odd number of elements
    (                                 #return the five numbers:
     $s[0],                                                 #min
     $oddh  ?  $s[$q1]  :  ( $s[$q1]    + $s[$q1+1] ) / 2,  #q1, first quartile
     $odd   ?  $s[$n/2] :  ( $s[$n/2-1] + $s[$n/2]  ) / 2,  #q2, median
     $oddh  ?  $s[$q3]  :  ( $s[$q3]    + $s[$q3+1] ) / 2,  #q3, third quartile
     $s[-1]                                                 #max
    )
}

sub five_simpler {                        #same simplified, sometimes adds two of same element before / 2
    my @s = sort { $a <=> $b } @_;
    my $q1 = int(@s/2-1)/2;
    my $q3 = @s-1-$q1;
    (                                     #float indexes use just the integer part
     $s[0],                               #min
     ( $s[$q1]      + $s[$q1+.51] ) / 2,  #q1
     ( $s[@s/2-.49] + $s[@s/2]    ) / 2,  #median
     ( $s[$q3]      + $s[$q3+.51] ) / 2,  #q3
     $s[-1]                               #max
    )
}

sub do_tests {
    for my $list (
      [73                 => [73,73,73,73,73] ],
      [11,12              => [11,11,11.5,12,12] ],
      [11,12,13           => [11,11,12,13,13] ],
      [11,12,13,14        => [11,11.5,12.5,13.5,14] ],
      [11,12,13,14,15     => [11,11.5,13,14.5,15] ],
      [11,12,13,14,15,16  => [11,12,13.5,15,16] ],
      [reverse(11 .. 17)  => [11,12,14,16,17] ],
    ) {
	my $expect = pop@$list;
	is_deeply( $_, $expect, sprintf"%-30s →  %s", "@$list", "@$_" )
	    for [five(@$list)],
	        [five_simpler(@$list)];
    }
    eval{five()}; ok($@,'no args, got expected croak');
    done_testing;
}
