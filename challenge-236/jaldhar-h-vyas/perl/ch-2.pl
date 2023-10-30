#!/usr/bin/perl
use 5.030;
use warnings;

my @ints = @ARGV;
my %seen;
my $loops = 1;
my $current = 0;

while (scalar keys %seen != scalar @ints) {
    if (exists $seen{$current}) {
        $loops++;

        for my $i (0 .. scalar @ints - 1) {
            if (!exists $seen{$i}) {
                $current = $i;
                last;
            }
        }
    }

    $seen{$current} = 1;
    $current = $ints[$current];
}

say $loops;
