#!/usr/bin/env perl

use Modern::Perl;

say smallest_index(@ARGV);

sub smallest_index {
    my(@ints) = @_;
    for my $i (0 .. $#ints) {
        return $i if ($i % 10) == $ints[$i];
    }
    return -1;
}
