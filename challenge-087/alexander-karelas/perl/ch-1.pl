#!/usr/bin/env perl

use v5.30;
use warnings;

# my @N = (10, 0, 3, 20, 2, 9, 11, 12, 1, 13);
my @N = (20, 19, 9, 11, 10);

my %N = map {($_, 0)} @N;

foreach my $m (keys %N) {
    for (my $n = $m; exists $N{$n}; $n++) {
        $N{$m}++;
    }
}

my ($start) = sort {$N{$b} <=> $N{$a}} keys %N;

if ($N{$start} == 1) {
    print "0\n";
} else {
    print "(" . join(", ", map {$start + $_} (0 .. $N{$start}-1)) . ")\n";
}
