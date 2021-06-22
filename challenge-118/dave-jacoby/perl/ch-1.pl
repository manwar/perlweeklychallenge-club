#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ postderef say signatures state };
no warnings qw{ experimental };

for my $n ( 0 .. 100 ) {
    say join "\t", '', $n, is_binary_palindrome($n);
}

sub is_binary_palindrome ( $n ) {
    my $b = sprintf '%b', $n;    # sprintf to get binary
    my $r = 0 + reverse $b;      # reverse to get reverse,
                                 # +0 to remove initial zeroes
    return $b eq $r ? 1 : 0;     # ternary because eq returns 1 and undef
}
