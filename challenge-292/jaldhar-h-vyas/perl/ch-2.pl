#!/usr/bin/perl
use v5.38;

sub clear($row) {
    while ($row =~ s/(.)\1\1+//g) {
    }

    return $row;
}

sub search($row, %handCount) {
    if ($row eq q{}) {
        return 0;
    }

    my $minInserts = 'Inf';

    for my $i (0 .. length($row)) {
        for my $color (keys %handCount) {
            if ($handCount{$color} < 1) {
                next;
            }

            $handCount{$color}--;
            my $newRow =
                clear(substr($row, 0, $i) . $color . substr($row, $i));
            $minInserts = min($minInserts, 1 + search($newRow, %handCount));
            $handCount{$color}++;
        }
    }

    return $minInserts;
}

sub min($a, $b) {
    return $a < $b ? $a : $b;
}

my $row = shift;
my @hand = split //, shift;
my %handCount;

for my $ball (@hand) {
    $handCount{$ball}++ ;
}

my $result = search($row, %handCount);

say $result == 'Inf' ? '-1' : $result;
