#!/usr/local/bin/perl

use v5.10;
use POSIX;
use strict;
use warnings;

my ($a, $b,);
my $number = $ARGV[0];
my $notFound = 1;

for (my $b = 2; $b < $number; $b++) {
    $a = $number ** (1 / $b);
    if (floor($a) ** $b == $number) {
        say floor($a), " ^ ", $b, " = ", $number;
        $notFound = 0;
    }
}

say "0" if $notFound;
