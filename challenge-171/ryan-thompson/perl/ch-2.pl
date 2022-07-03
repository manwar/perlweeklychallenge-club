#!/usr/bin/env perl
#
# ch-2.pl - First class functions
#
# 2022 Ryan Thompson <rjt@cpan.org>

use 5.010;
use warnings;
use strict;
no warnings 'uninitialized';

use List::Util qw< sum0 >;

my $squares = sub { map { $_ * $_ } @_ };
my $h = comp( \&sum0, $squares );

say "The sum of squares for 1..10 = " . $h->(1..10);

# Demonstrate function composition
sub comp {
    my ($f, $g) = @_;

    sub { $f->($g->(@_)) }
}
