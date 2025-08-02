#!/usr/bin/perl
use v5.38;
use builtin qw/ true /;
no warnings qw/ experimental::builtin /;

my $str = shift;
my @boxes;

while ($str =~ /(([RGB]) (\d))/gmx) {
    my ($color, $box) = ($2, $3);
    $boxes[$box]{$color} = true;
}

say scalar grep { scalar keys %{$_} == 3 } @boxes;
