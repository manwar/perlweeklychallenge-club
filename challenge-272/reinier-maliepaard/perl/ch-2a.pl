#!/usr/bin/perl
use strict;
use warnings;

sub ascii_differences_sum_split_2_alt
{
    my ( $t, @list ) = ( 0, split(//, $_[0]) );

    my $f = ord( shift(@list) );

    for (@list) {
        $t += abs( $f - ord($_) );
        $f = ord($_);
    }
    return($t);
}
