#!/usr/bin/env perl

use strict;
use warnings;
use utf8::all;
use feature "say";
use experimental "signatures";

sub main ( $str1, $str2 ) {
    # Extract the integers from the two strings
    my @arr1 = ( $str1 =~ /(\d+)/g );
    my @arr2 = ( $str2 =~ /(\d+)/g );

    my @sorted_array = sort { $a <=> $b } ( @arr1, @arr2 );
    my $half         = int( $#sorted_array / 2 );
    my $median =
      $#sorted_array % 2
      ? ( $sorted_array[$half] + $sorted_array[ $half + 1 ] ) / 2
      : $sorted_array[$half];

    say sprintf( "%0.1f", $median );
}

main(@ARGV);
