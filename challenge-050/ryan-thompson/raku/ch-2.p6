#!/usr/bin/env perl6

# ch-2.p6 - Noble integers
#
# Ryan Thompson <rjt@cpan.org>

sub noble( *@L ) {
    @L.sort.pairs.grep({ @L.end - .key == .value })».value;
}

say noble((1..$_).pick xx $_) for ^30;
say "PWC test case: ", noble(2, 6, 1, 3);
