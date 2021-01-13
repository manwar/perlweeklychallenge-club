#!/usr/bin/perl

use warnings;
use strict;
use 5.10.0;

my $str = join(" ", 1..50);

while ($str =~ m(^(\S+) (\S+) (.*))) {
    $str = "$3 $1";
}

$str =~ s/ .*//;
say "survivor: $str";
