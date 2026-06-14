#!/usr/bin/env perl

use strict;
use warnings;
use utf8::all;
use feature "say";
use experimental "signatures";

use Algorithm::Combinatorics 'combinations';

sub is_prefix_suffix ( $s1, $s2 ) {
    my $l = length($s2);

    return ( substr( $s1, 0, $l ) eq $s2 and substr( $s1, 0 - $l ) eq $s2 )
      ? 1
      : 0;

}

sub main (@array) {
    my $count = 0;

    my $iter = combinations( \@array, 2 );
    while ( my $c = $iter->next ) {
        my ( $str1, $str2 ) = @$c;
        if (   is_prefix_suffix( $str1, $str2 )
            or is_prefix_suffix( $str2, $str1 ) )
        {
            ++$count;
        }
    }

    say $count;
}

main(@ARGV);
