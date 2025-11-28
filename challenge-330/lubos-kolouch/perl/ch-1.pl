#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(signatures);
no warnings qw(experimental::signatures);

=head1 DESCRIPTION

Clear all digits from the supplied string by repeatedly removing each
digit and the closest non-digit character to its left. Returns the
remaining characters as a new string.

=cut

sub clear_digits ($str) {
    my @stack;
    for my $ch (split //, $str) {
        if ($ch =~ /\d/) {
            pop @stack if @stack;    # remove the closest non-digit to the left
        }
        else {
            push @stack, $ch;
        }
    }
    return join '', @stack;
}

if (!caller) {
    require Test::More;
    Test::More::is( clear_digits('cab12'), 'c',    'Example 1' );
    Test::More::is( clear_digits('xy99'),  '',     'Example 2' );
    Test::More::is( clear_digits('pa1erl'), 'perl', 'Example 3' );
    Test::More::done_testing();
}
