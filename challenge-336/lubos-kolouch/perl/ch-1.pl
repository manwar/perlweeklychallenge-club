#!/usr/bin/env perl
use strict;
use warnings;

=head1 NAME

ch-1.pl - The Weekly Challenge 336 Task 1: Equal Group

=head1 DESCRIPTION

Determine whether an array of integers can be partitioned into one or more
groups so that:

=over 4

=item * all groups have the same size (at least two members), and

=item * all values inside each group are identical.

=back

The implementation counts occurrences of each value and verifies that the
greatest common divisor of the counts is at least two.

=head1 AUTHOR

Lubos Kolouch

=cut

use List::Util qw(all reduce);
use Test::More tests => 5;

use constant IntArray => 'ARRAY';

sub _gcd {
    my ( $a, $b ) = @_;
    ( $a, $b ) = ( abs $a, abs $b );
    return $a if $b == 0;
    return _gcd( $b, $a % $b );
}

sub equal_group {
    my (@ints) = @_;
    return 0 if @ints < 2;

    my %freq;
    $freq{$_}++ for @ints;
    my @counts = values %freq;

    return 0 if !all { $_ >= 2 } @counts;

    my $gcd = reduce { _gcd( $a, $b ) } @counts;
    return $gcd >= 2 ? 1 : 0;
}

subtest 'Example 1' => sub {
    my @ints = ( 1, 1, 2, 2, 2, 2 );
    ok( equal_group(@ints), 'Groups (1,1), (2,2), (2,2)' );
};

subtest 'Example 2' => sub {
    my @ints = ( 1, 1, 1, 2, 2, 2, 3, 3 );
    ok( !equal_group(@ints), 'Cannot group equally' );
};

subtest 'Example 3' => sub {
    my @ints = ( 5, 5, 5, 5, 5, 5, 7, 7, 7, 7, 7, 7 );
    ok( equal_group(@ints), 'Groups of size 6' );
};

subtest 'Example 4' => sub {
    my @ints = ( 1, 2, 3, 4 );
    ok( !equal_group(@ints), 'Distinct values cannot group' );
};

subtest 'Example 5' => sub {
    my @ints = ( 8, 8, 9, 9, 10, 10, 11, 11 );
    ok( equal_group(@ints), 'Pairs of equal values' );
};
