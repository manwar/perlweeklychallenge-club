#!/usr/bin/perl
use 5.030;
use warnings;

sub partitions {
    my ($n) = @_;
    my @combos;
    my @piles;
    my $i = 0;
    $piles[$i] = $n;

    while (1) {
        push @combos, [@piles];

        my $remainder = 0;
        while ($i >= 0 && $piles[$i] == 1) {
            $remainder += $piles[$i];
            $i--;
        }

        if ($i < 0) {
            last;
        }

        $piles[$i]--;
        $remainder++;

        while ($remainder > $piles[$i]) {
            $piles[$i + 1] = $piles[$i];
            $remainder = $remainder - $piles[$i];
            $i++;
        }
        $piles[$i + 1] = $remainder;
        $i++;
    }

    return @combos;
}

my $n = shift;

say scalar partitions(5);