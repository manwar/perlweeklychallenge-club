#!/usr/bin/perl
use 5.038;
use warnings;
use builtin qw/ true false /;
no warnings qw/ experimental::builtin /;

my @n = shift =~ /(\d+)/g;
my $result = true;

for my $i (1 .. scalar @n - 1) {
    if ($n[$i] < $n[$i- 1]) {
        $result = false;
        last
    }
}

say $result ? "true" : "false";