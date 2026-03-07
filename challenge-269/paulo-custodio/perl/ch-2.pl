#!/usr/bin/env perl

use Modern::Perl;

say "(", join(", ", distribute(@ARGV)), ")";

sub distribute {
    my(@ints) = @_;
    return @ints if @ints < 2;
    my @a1 = (shift @ints);
    my @a2 = (shift @ints);
    while (@ints) {
        if ($a1[-1] > $a2[-1]) {
            push @a1, shift @ints;
        }
        else {
            push @a2, shift @ints;
        }
    }
    return (@a1, @a2);
}
