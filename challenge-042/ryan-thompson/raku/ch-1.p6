#!/usr/bin/env perl6

# ch-1.p6 - Print octal numbers from 0..50
#
# Ryan Thompson <rjt@cpan.org>

# Perl5 method still works, verbatim
printf "Decimal %2d = Octal %2o\n", $_, $_ for 0..50;

# This is my preferred solution:
say (0..50).fmt('Decimal %1$2d = Octal %2o', "\n");
