#!/usr/bin/perl
# Test: ./ch-1.pl
use strict;
use warnings;
use feature qw /say/;

my @numbers = (1, 2, 3, 4, 6);
my %rings = (
    blue   => 8,
    yellow => 7,
    green  => 5,
    red    => 9,
    black  => 0
);

for my $ring ( keys %rings ) {
    my $total = $rings{$ring};
    my @additional_numbers;
    for my $i (sort { $b <=> $a } @numbers) {
        if ($total + $i <= 11) {
            $total += $i;
            push @additional_numbers, $i;
        }
    }

    say 'Color: ' . $ring . ' - ' .
         join ', ', @additional_numbers;
}
