#!/usr/bin/env perl

use strict;
use warnings;
use utf8::all;
use feature "say";
use experimental "signatures";

use List::Util 'max';

sub get_change( $ints, $p ) {
    my $i = $ints->[$p];
    my $j = $ints->[ $p + 1 ];
    if ( $i == $j ) {
        return "s";
    }
    return $j > $i ? "h" : "l";
}

sub main (@ints) {
    # Get pattern (higher, lower, same)
    my $pattern = join "", map { get_change( \@ints, $_ ) } ( 0 .. $#ints - 1 );

    # Find longest run of alternating higher and lower characters, as well as
    #  a single one.
    say max(
        map ( { length($_) + 1 } $pattern =~ /(h?(?:lh)+|l?(?:hl)+|[hl])/g ),
        1 );
}

main(@ARGV);
