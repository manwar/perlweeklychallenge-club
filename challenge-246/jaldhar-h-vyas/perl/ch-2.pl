#!/usr/bin/perl
use 5.030;
use warnings;

my @a = @ARGV;

if (scalar @a != 5) {
    die "Need a sequence of five integers.\n";
}

for my $p (-10 .. 10) {
    for my $q (-10 .. 10) {
        if ($a[3] ==  $p * $a[1] + $q * $a[2] && $a[4] ==  $p * $a[2] + $q * $a[3]) {
            say 'true';
            exit;
        }
    }
}

say 'false';
