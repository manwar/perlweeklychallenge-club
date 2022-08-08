#!/usr/bin/perl
use 5.030;
use warnings;
use experimental qw/ smartmatch /;

sub isReversible {
    my ($n) = @_;

    return $n + (0 + reverse $n) ~~ /^ [13579]+ $/msx;
}

my @reversibles;

for my $n (1 .. 99) {
    if (isReversible($n)) {
        push @reversibles, $n;
    }
}

say join q{, }, @reversibles;
