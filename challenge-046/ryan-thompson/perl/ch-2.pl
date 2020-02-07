#!/usr/bin/env perl
#
# ch-2.pl - 500 Doors
#
# 2020 Ryan Thompson <rjt@cpan.org>

use 5.010;
use warnings;
use strict;
no warnings 'uninitialized';

my $doors = shift || 500;

# Justification: http://www.ry.ca/2020/02/500-doors/
say join ' ', map { $_ * $_ } 1..int sqrt $doors;


# That's fine, I can do it the hard way:
my %door;
for my $m (1..$doors) {
    $door{$m*$_} ^= 1 for 1..$doors/$m;
}
say join ' ', grep { $door{$_} }
              sort { $a <=> $b } keys %door;

