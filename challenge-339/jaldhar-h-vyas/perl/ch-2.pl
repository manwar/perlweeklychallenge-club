#!/usr/bin/perl
use 5.038;
use warnings;

sub max(@arr) {
    my $highest = '-inf';
    for my $i (@arr) {
        if ($i > $highest) {
            $highest = $i;
        }
    }

    return $highest;
}

my @changes = (0);

for (@ARGV) {
    push @changes, $changes[-1] + $_;
}

say max(@changes);