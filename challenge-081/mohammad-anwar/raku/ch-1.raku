#!/usr/bin/env raku

#
# Perl Weekly Challenge - 081
#
# Task #1: Common Base String
#
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-081
#

use v6.d;

sub MAIN(Str :$string1 = "abcdabcd",
         Str :$string2 = "abcdabcdabcdabcd") {

    common-base-strings($string1, $string2).say;
}

#
#
# SUBROUTINE

sub common-base-strings(Str $string1, Str $string2 --> Str) {

    my $len_string1 = $string1.chars;
    my $len_string2 = $string2.chars;

    my ($min_size, $min_string);
    if ($len_string1 > $len_string2) {
        $min_string = $string2;
        $min_size   = $len_string2;
    }
    else {
        $min_string = $string1;
        $min_size   = $len_string1;
    }

    my @common_base_strings = ();
    for 1 .. $min_size -> $i {
        my $base_str = substr($min_string, 0, $i);
        @common_base_strings.push: $base_str
            if ($string1 eq $base_str x 2)
               ||
               ($string2 eq $base_str x 2);
    }

    return @common_base_strings.join(", ");
}
