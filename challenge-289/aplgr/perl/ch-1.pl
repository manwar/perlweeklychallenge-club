use strict;
use warnings;

sub third_maximum {
    my @ints = @_;

    my %unique = map { $_ => 1 } @ints;
    my @distinct = sort { $b <=> $a } keys %unique;

    return @distinct >= 3 ? $distinct[2] : $distinct[0];
}

1;