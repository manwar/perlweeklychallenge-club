#!/usr/bin/perl
use warnings;
use strict;
use 5.010;

my $num = shift;
my $multiple = $num;

while ($multiple !~ / \A [01]+ \z /gmx) {
    $multiple += $num;
}

say $num, ' x ', $multiple / $num, ' = ', $multiple;
