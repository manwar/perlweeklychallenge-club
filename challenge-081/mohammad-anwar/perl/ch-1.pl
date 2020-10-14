#!/usr/bin/perl

#
# Perl Weekly Challenge - 081
#
# Task #1: Common Base String
#
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-081
#

use strict;
use warnings;

my $S1 = $ARGV[0] || "abcdabcd";
my $S2 = $ARGV[1] || "abcdabcdabcdabcd";

printf("Common Base String(s): %s\n",
       join(", ", common_base_strings($S1, $S2)));

#
#
# SUBROUTINE

sub common_base_strings {
    my ($string1, $string2) = @_;

    die "ERROR: Missing string1.\n" unless defined $string1;
    die "ERROR: Missing string2.\n" unless defined $string2;

    my $len_string1 = length($string1);
    my $len_string2 = length($string2);

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
    for my $i (1 .. $min_size) {
        my $base_str = substr($min_string, 0, $i);
        push @common_base_strings, $base_str
            if (($string1 eq $base_str x 2)
                ||
                ($string2 eq $base_str x 2));
    }

    return @common_base_strings;
}
