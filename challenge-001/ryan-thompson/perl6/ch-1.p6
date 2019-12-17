#!/usr/bin/env perl6

# ch-1.p6 - s/e/E/g
#
# Ryan Thompson <rjt@cpan.org>

use v6;

my Str $str = 'Perl Weekly Challenge';
my $distance = $str ~~ tr/e/E/;
say "$str -> e x " ~ $distance.Int;
