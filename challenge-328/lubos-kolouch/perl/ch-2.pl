#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(signatures);
no warnings qw(experimental::signatures);

=head1 DESCRIPTION

Good String (Weekly Challenge 328)

Reduce a string by repeatedly removing adjacent pairs of the same letter
in opposite cases (e.g., 'aA' or 'Aa'). Return the resulting good
string.

=cut

sub good_string ($s) {
    my @stack;
    for my $ch (split //, $s) {
        if (@stack && lc($stack[-1]) eq lc($ch) && $stack[-1] ne $ch) {
            pop @stack;
        }
        else {
            push @stack, $ch;
        }
    }
    return join '', @stack;
}

if (!caller) {
    require Test::More;
    Test::More::is( good_string('WeEeekly'), 'Weekly', 'Example 1' );
    Test::More::is( good_string('abBAdD'), '', 'Example 2' );
    Test::More::is( good_string('abc'), 'abc', 'Example 3' );
    Test::More::done_testing();
}
