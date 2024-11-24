#https://theweeklychallenge.org/blog/perl-weekly-challenge-296/
#sub can_make_square() for a list of integer stick lengths return true
#if the sticks can make up the sides of a square. It makes use of the
#more general can_make_sums() that return true if the sticks can make
#up each of the given sums which in our case is just the side length
#times four.  The side length is the sum of all stocks divided by
#four.  can_make_sums() tries each combination of sticks to make the
#first side length and then recursively tries the rest of the stickes
#(lengths) to make up the rest of the side lengths. If the last sum is
#also 0 then the whole list can make up a square.

use strict; use warnings; use v5.10; use List::Util qw(sum any shuffle); use Test::More;

sub can_make_sums {
    my($sums, $list) = @_;
    $$sums[0] < 0  ? ()
  : $$sums[0] == 0 ? @$sums==1 ? 1 : can_make_sums( [ @$sums[ 1 .. $#$sums ] ], $list )
  : any {
      can_make_sums( [$$sums[0] - $$list[$_], @$sums[ 1 .. $#$sums ] ], [ @$list[ 0 .. $_-1, $_+1 .. $#$list ] ] )
    } 0 .. $#$list
}

sub can_make_square {
    can_make_sums( [ (&sum/4) x 4], [@_] );
}

@ARGV ? say can_make_square(@ARGV) ? 'yes' : 'no' : tests();

sub tests {
    my($true, $false) = (1, '');
    for my $test (
	[ 1, 2, 2, 2, 1    => $true  ],
	[ 2, 2, 2, 4       => $false ],
	[ 2, 2, 2, 2, 4    => $false ],
	[ 3, 4, 1, 4, 3, 1 => $true  ],
	[ 2, 7, 2, 1, 6, 5, 3, 2, 2, 9, 1 => $true ],
	[ 2, 7, 2, 1, 6, 5, 3, 2, 2, 9, 4 => $false ],
	[ shuffle(1..10, 1..10, 1..10, 1..10) => $true ],
	[ shuffle(1..4, 1..4, 1..4, 1..4)     => $true ],
	[ shuffle(1..4, 1..4, 1..4, 1..3,3)   => $false ],
	){
	my $want = pop @$test;
	my @sticks = @$test;
	my $got = can_make_square( @sticks );
	is $got, $want;
    }
    done_testing;
}
