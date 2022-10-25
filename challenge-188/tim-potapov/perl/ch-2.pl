#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;

=pod

 Task 2: Total Zero
 You are given two positive integers $x and $y.

  Write a script to find out the number of operations needed to make both ZERO.
  Each operation is made up either of the followings:

    $x = $x - $y if $x >= $y
    
    or
    
    $y = $y - $x if $y >= $x (using the original value of $x)

=cut


sub NumOps {
    my ( $x, $y ) = @_;
    my $count = 0;

    while ( $x and $y ) {
        my $x_original = $x;
        my $up;

        $x -= $y,          $up++ if $x >= $y;
        $y -= $x_original, $up++ if $y >= $x_original;

        $count++ if $up;
    }

    $count;
}

my @cases = (
    {
        Name   => 'Example 1',
        X      => 5,
        Y      => 4,
        Output => 5,
    },
    {
        Name   => 'Example 2',
        X      => 4,
        Y      => 6,
        Output => 3,
    },
    {
        Name   => 'Example 3',
        X      => 2,
        Y      => 5,
        Output => 4,
    },
    {
        Name   => 'Example 4',
        X      => 3,
        Y      => 1,
        Output => 3,
    },
    {
        Name   => 'Example 5',
        X      => 7,
        Y      => 4,
        Output => 5,
    },
);

for ( @cases ) {
    is( NumOps( $_->{X}, $_->{Y} ), $_->{Output}, $_->{Name} );
}

done_testing();
