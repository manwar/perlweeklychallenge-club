#!/usr/bin/perl
use 5.030;
use warnings;

my @n = @ARGV;
unless (@n) {
    die "Need a list of integers\n";
}

my $max = "-Inf";
my $index;

while (my ($key, $value) = each @n) {
    if ($value > $max)  {
        $max = $value;
        $index = $key;
    }
}

say $index;
