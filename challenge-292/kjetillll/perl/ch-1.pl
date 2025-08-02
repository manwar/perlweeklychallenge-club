#https://theweeklychallenge.org/blog/perl-weekly-challenge-292/
#Write a script to find whether the largest of the unique input elements is at least twice as
#big as every other element. If so return the index of the largest element or -1 otherwise.

use strict; use warnings;

sub largest_twice_index {
    my($largest, $i_largest, $second_largest);
    for my $i ( 0 .. $#_ ){
	if( !defined$largest or $_[$i] >= $largest ) {
	    ($largest, $second_largest, $i_largest) = ($_[$i], $largest, $i)
	}
    }
    defined $largest && ( !defined $second_largest || $largest >= $second_largest*2)
	? $i_largest : -1
}

@ARGV and print largest_twice_index(@ARGV), "\n" and exit;

use Test::More;
is largest_twice_index(2, 4, 1, 0) => 1;
is largest_twice_index(1, 2, 3, 4) => -1;
is largest_twice_index(-4, -3, -2) => 2;
done_testing;
