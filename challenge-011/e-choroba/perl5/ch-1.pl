#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

sub f_to_c {
    my ($f) = @_;
    ($f - 32) / (212 - 32) * 100
}

use Test::More;
is f_to_c(32), 0;
is f_to_c(212), 100;
done_testing(2);

my $f = rand(800) - 400;
my $step = 100;
my $dir = 1;
while ($dir) {
    my $c = f_to_c($f);
    $f += $dir * $step;
    $step /= 2 if $dir == ($f <=> $c);
    $dir = ($c <=> $f);
}
printf "%.4f\n", $f;
