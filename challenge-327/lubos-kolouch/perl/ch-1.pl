#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(signatures);
no warnings qw(experimental::signatures);

=head1 DESCRIPTION

Missing Integers (Weekly Challenge 327)

Given an array of n integers, return all missing integers in the range
1..n. Duplicates may appear; order the result ascending.

=cut

sub missing_integers (@ints) {
    my $n = scalar @ints;
    my %present;
    $present{$_} = 1 for @ints;
    my @missing = grep { !$present{$_} } 1 .. $n;
    return \@missing;
}

if (!caller) {
    require Test::More;
    Test::More::is_deeply( missing_integers(1, 2, 1, 3, 2, 5), [4, 6], 'Example 1' );
    Test::More::is_deeply( missing_integers(1, 1, 1), [2, 3], 'Example 2' );
    Test::More::is_deeply( missing_integers(2, 2, 1), [3], 'Example 3' );
    Test::More::done_testing();
}
