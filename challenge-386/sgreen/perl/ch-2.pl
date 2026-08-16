#!/usr/bin/env perl

use strict;
use warnings;
use utf8::all;
use feature "say";
use experimental "signatures";

use List::Util qw(max uniq);

sub extend_part( $rat_part, $part_length ) {
    my $s = $rat_part->[1];
    while ( length($s) < $part_length ) {
        $s .= $rat_part->[2];
    }

    return substr( $s, 0, $part_length );
}

sub main (@rats) {
    # Convert rational numbers into three parts (whole number, part before the
    #  parentheses, and part within the parentheses)
    my @rat_parts = ();
    foreach my $rat (@rats) {
        if ( my $parts = ( $rat =~ /(\d*)(?:\.(\d*)(?:\((\d+)\))?)?$/ ) ) {
            push @rat_parts, [ $1 // "0", $2 // "", $3 // "0" ];
        }
        else {
            die "The value $rat is invalid!\n";
        }
    }

    # If the whole part isn't the same, return false early
    if ( scalar( uniq map { $_->[0] } @rat_parts ) != 1 ) {
        say "false";
        return;
    }

    # For the rest of the rational number, check they are all the same if
    #  expanding the recurring amount to at least twice the length of the
    #  longest number
    my $part_length =
      max( map { length( $_->[1] ) + 2 * length( $_->[2] ) } @rat_parts );
    if (
        scalar( uniq map { extend_part( $_, $part_length ) } @rat_parts ) != 1 )
    {
        say "false";
        return;
    }

    say "true";
}

main(@ARGV);
