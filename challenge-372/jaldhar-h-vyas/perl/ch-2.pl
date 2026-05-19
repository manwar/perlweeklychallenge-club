#!/usr/bin/perl
use 5.40.1;
use warnings;

my ($str) = @ARGV;
my %positions;

for my ($index, $char) (indexed split //, $str) {
    push @{$positions{$char}}, $index;
}

my $max = -1;

for my $indices (values %positions) {
    if (scalar @{$indices} > 1) {
        my $distance = $indices->[-1] - $indices->[0] - 1;
        if ($distance > $max) {
            $max = $distance 
        }
    }
}

say $max;
