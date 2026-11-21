#!/usr/bin/env perl
use v5.38;
use warnings;
use Type::Params -sigs;
use Types::Standard qw(Int);
use Test::More;

=head1 NAME

ch-1.pl - Largest Interval

=head1 SYNOPSIS

    perl ch-1.pl

=head1 DESCRIPTION

Solution for The Weekly Challenge 400, Task 1: Largest Interval.
Generates integers from C<1> to C<$limit>, filters out numbers containing
repeating digits, and returns the largest difference between consecutive
remaining numbers.

=head1 FUNCTIONS

=head2 largest_interval($limit)

Returns the maximum gap between consecutive integers in C<1..$limit> that
have all distinct digits.

=cut

signature_for largest_interval => (
    method     => 0,
    positional => [Int],
);

sub largest_interval ($limit) {
    my $prev     = 1;
    my $max_jump = 0;

    for my $num ( 2 .. $limit ) {
        next if $num =~ m/(\d).*\1/msx;
        my $jump = $num - $prev;
        $max_jump = $jump if $jump > $max_jump;
        $prev     = $num;
    }

    return $max_jump;
}

is( largest_interval(20),    2,   'Example 1' );
is( largest_interval(110),   4,   'Example 2' );
is( largest_interval(500),   11,  'Example 3' );
is( largest_interval(2026),  105, 'Example 4' );
is( largest_interval(10000), 105, 'Example 5' );
done_testing();
