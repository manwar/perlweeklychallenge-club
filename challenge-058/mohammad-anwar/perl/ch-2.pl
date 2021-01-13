#!/usr/bin/perl

use strict;
use warnings;

my $H = [2, 6, 4, 5, 1, 3];
my $T = [1, 0, 2, 0, 1, 2];
my $O = order_lineup({ H => $H, T => $T });

print sprintf("\@H = (%s)\n", join(", ", @$H));
print sprintf("\@T = (%s)\n", join(", ", @$T));
print sprintf("\@O = (%s)\n", join(", ", @$O));

sub order_lineup {
    my ($args) = @_;

    my @H = @{$args->{H}};
    my @T = @{$args->{T}};
    my $O = [];

    my $H_T = { map { $H[$_] => $T[$_] } 0 .. scalar(@H)-1 };
    foreach my $h (sort { $b <=> $a } keys %$H_T) {

        my $i = 0;
        my $j = 0;

        while ($H_T->{$h} > $j) {
            $j++ if ($O->[$i] > $h);
            $i++;
        }

        splice @$O, $i, 0, $h;
    }

    return $O;
}
