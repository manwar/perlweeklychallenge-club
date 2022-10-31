#!/usr/bin/env perl

use v5.30.0;

=pod
You are given two positive integers $x and $y.

Write a script to find out the number of operations needed to make both ZERO. Each operation is made up either of the followings:

$x = $x - $y if $x >= $y

or

$y = $y - $x if $y >= $x (using the original value of $x)

=cut

sub total_zero
{
    my ( $x, $y ) = @_;

    my $count = 0;
    while ( $x > 0 or $y > 0 )
    {
        $count++;
        if ( $x == $y )
        {
            return $count;
        }
        elsif ( $x > $y )
        {
            $x -= $y;
        }
        else
        {
            $y -= $x;
        }
    }
    return;
}

sub total_zero_recursive
{
    my ( $x, $y ) = @_;
    return 1 + (
          $x > $y ? total_zero_recursive( $x - $y, $y )
        : $x < $y ? total_zero_recursive( $x,      $y - $x )
        : 0
    );
}

use Test::More;
my $test_data = [
    [ ( 5, 4 ) => 5 ],
    [ ( 4, 6 ) => 3 ],
    [ ( 2, 5 ) => 4 ],
    [ ( 3, 1 ) => 3 ],
    [ ( 7, 4 ) => 5 ],
];
for my $test (@$test_data)
{
    my ( $x, $y, $expected ) = @$test;
    say "# $x, $y => $expected";
    my $count = total_zero( $x, $y );
    is $count, $expected, "got $count expected $expected";
    my $count = total_zero_recursive( $x, $y );
    is $count, $expected, "got $count expected $expected";
}
done_testing;
