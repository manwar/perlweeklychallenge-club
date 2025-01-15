#!/usr/bin/perl
use v5.38;
use builtin qw/ true false /;
no warnings 'experimental::builtin';

my $n = shift;
my @digits = @ARGV;
my $replacements = 0;

for my $i (1 .. scalar @digits - 1) {
    if ($digits[$i - 1] == 0 && $digits[$i] == 0)  {
        $digits[$i] = 1;
        $replacements++;
    }
}

my $result = false;

if ($replacements >= $n) {
    $result = true;

    for my $i (1 .. scalar @digits - 1) {
        if ($digits[$i - 1] == 1 && $digits[$i] == 1) {
            $result = false;
            last;
        }
    }
}

say $result ? 'true' : 'false';
