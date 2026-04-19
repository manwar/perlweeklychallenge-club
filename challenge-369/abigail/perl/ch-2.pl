#!/opt/perl/bin/perl

#
# As a one-liner:
#
# perl -alpE '$_="@{[($F[0].($F[2]x($F[1]-1)))=~/${\(q!.!x$F[1])}/g]}"'
#

use 5.042;

use strict;
use warnings;
no  warnings 'syntax';

while (<>) {
    #
    # Parse input
    #
    my ($str, $size, $filler) = split;

    #
    # Add filler characters to $str
    #
    $str .= $filler x ($size - 1);

    #
    # While we have at least $size characters in $str, chop off the 
    # first $size characters, and add them to @out.
    #
    my @out;
    while (length ($str) >= $size) {
        push @out => substr $str, 0, $size, ""
    }
    say "@out"
}

__END__
