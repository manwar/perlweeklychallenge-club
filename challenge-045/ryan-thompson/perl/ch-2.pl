#!/usr/bin/env perl
#
# ch-2.pl - Cheaty quine, but passes the challenge test
#
# Ryan Thompson <rjt@cpan.org>

open my $fh, '<', __FILE__; # Or $0
print do { undef $/; <$fh> };
