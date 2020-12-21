#!/usr/bin/perl
use 5.020;
use warnings;

sub jump {
    my @N = @_;
    my $current = 0;

    while ( $current < (scalar @N - 1)) {
        $current += $N[$current];
        if ($N[$current] == 0 || $current > scalar @N) {
            return 0;
        }
    }

    return 1;
}

say jump(@ARGV);
