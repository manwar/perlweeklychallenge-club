#!/usr/bin/env perl
use v5.38;
use warnings;
use List::Util qw(min);
use Type::Params -sigs;
use Types::Standard qw(Str);
use Test::More;

=head1 NAME

ch-1.pl - Shortest Distance

=head1 SYNOPSIS

    perl ch-1.pl

=head1 DESCRIPTION

Solution for The Weekly Challenge 248, Task 1: Shortest Distance.
Given a string C<$str> and a character C<$char> present in C<$str>, returns an
array reference of integers of the same length as C<$str>, where each element
at index C<$i> is the minimum distance C<abs($i - $j)> to any occurrence C<$j>
of C<$char> in C<$str>.

=head1 FUNCTIONS

=head2 shortest_distance($str, $char)

Takes a string C<$str> and a single character C<$char>, and returns an array
reference containing the shortest distance from each index in C<$str> to the
closest occurrence of C<$char>.

=cut

signature_for shortest_distance => (
    method     => 0,
    positional => [ Str, Str ],
);

sub shortest_distance ( $str, $char ) {
    my $len = length($str);
    return [] if $len == 0;

    my @positions = grep { substr( $str, $_, 1 ) eq $char } 0 .. $len - 1;
    die "Character '$char' not found in string\n" unless @positions;

    my @distances = map {
        my $i = $_;
        min( map { abs( $i - $_ ) } @positions );
    } 0 .. $len - 1;

    return \@distances;
}

is_deeply(
    shortest_distance( 'loveleetcode', 'e' ),
    [ 3, 2, 1, 0, 1, 0, 0, 1, 2, 2, 1, 0 ],
    'Example 1'
);
is_deeply(
    shortest_distance( 'aaab', 'b' ),
    [ 3, 2, 1, 0 ],
    'Example 2'
);
done_testing();
