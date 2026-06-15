#!/usr/bin/env perl

use strict;
use warnings;
use utf8::all;
use feature "say";
use experimental "signatures";

sub word_to_number($str) {
    # Check the word only contains the letters 'a' to 'j'
    if ( $str !~ /^[a-j]+$/ ) {
        die "String '$str' contains invalid characters\n";
    }

    # Convert into an integer
    my $number_string = join( "", map { ord($_) - ord('a') } split //, $str );
    return int($number_string);
}

sub main ( $str1, $str2, $str3 ) {
    say word_to_number($str1) + word_to_number($str2) == word_to_number($str3)
      ? 'true'
      : 'false';
}

main(@ARGV);
