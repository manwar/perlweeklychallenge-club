#!/usr/bin/perl
use strict;
use warnings;

sub sparkline {
    my @n = @_;

    my $max = $n[0];
    for my $i ( 1 .. $#n ) {
        $max = $n[$i] if $n[$i] > $max;
    }

    my @spark_chars = (
        "\x{2581}", "\x{2582}", "\x{2583}", "\x{2584}",
        "\x{2585}", "\x{2586}", "\x{2587}", "\x{2588}"
    );

    my $sparkline = '';
    for my $i ( 0 .. $#n ) {
        my $height = int( $n[$i] / $max * $#spark_chars );
        $sparkline .= $spark_chars[$height];
    }

    return $sparkline;
}

print sparkline(@ARGV);
