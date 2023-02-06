#!/usr/bin/perl
use 5.030;
use warnings;

my @vallies;

for my $i (0 .. scalar @ARGV - 1) {
    my @valley;
    my $ascending = undef;

    for my $j ($i .. scalar @ARGV - 1) {
        if ($ascending && scalar @valley && $ARGV[$j] < $valley[-1]) {
            $ascending = undef;
            last;
        } elsif (!$ascending && scalar @valley && $ARGV[$j] > $valley[-1]) {
            $ascending = 1;
        }
        push @valley, $ARGV[$j];
    }
    push @vallies, [ @valley ];
}

say join q{, }, @{ (sort { scalar @{$b} <=> scalar @{$a} } @vallies)[0] };
