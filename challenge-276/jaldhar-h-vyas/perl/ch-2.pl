#!/usr/bin/perl
use v5.38;

my @ints = @ARGV;

my %freq;

for my $int (@ints) {
    $freq{$int}++;
}

my $max = 0;
my $output = 0;

while (my ($k, $v) = each %freq) {
    if ($v > $max) {
        $max = $v;
        $output = 1;
    } elsif ($v == $max) {
        $output++;
    }
}

say $output;
