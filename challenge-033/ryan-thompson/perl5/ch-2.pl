#!/usr/bin/env perl

# challenge-033/ch-2.pl - Print multiplication table up to $max * $max
#
# Ryan Thompson <rjt@cpan.org>

use 5.010;
use strict;
use warnings;

my $max   = shift // 11;
my $width = length $max * $max; # Widest possible number for printf
my $fmt   = join(' ', "%${width}s %3s", ("%${width}s") x $max) . "\n";

printf $fmt, 'x', ' | ', 1..$max;
printf $fmt, '-' x $width, '-+-', ('-' x $width) x $max;

for my $x ( 1..$max ) {
    printf $fmt, $x, ' | ', map { $x > $_ ? '' : $x * $_ } 1..$max;
}
