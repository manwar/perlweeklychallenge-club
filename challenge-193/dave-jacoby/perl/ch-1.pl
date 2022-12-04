#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ fc say postderef signatures state };

for my $s ( 2 .. 5 ) {
    my @binaries = all_binaries($s);
    my $binaries = join ', ', @binaries;
    say <<"END";
    Input:  \$n = $s
    Output: $binaries
END

}

sub all_binaries ( $size, $b = '', $i = 0 ) {
    return $b if length $b == $size;
    my @output;
    push @output, all_binaries( $size, $b . '0', $i + 1 );
    push @output, all_binaries( $size, $b . '1', $i + 1 );
    return @output;
}
