#!/usr/bin/env perl

# Challenge 053
#
# TASK #2
# Vowel Strings
# Write a script to accept an integer 1 <= N <= 5 that would print all possible
# strings of size N formed by using only vowels (a, e, i, o, u).
#
# The string should follow the following rules:
#
# ‘a’ can only be followed by ‘e’ and ‘i’.
#
# ‘e’ can only be followed by ‘i’.
#
# ‘i’ can only be followed by ‘a’, ‘e’, ‘o’, and ‘u’.
#
# ‘o’ can only be followed by ‘a’ and ‘u’.
#
# ‘u’ can only be followed by ‘o’ and ‘e’.
#
# For example, if the given integer N = 2 then script should print the following
# strings:
#
# ae
# ai
# ei
# ia
# io
# iu
# ie
# oa
# ou
# uo
# ue

use Modern::Perl;

my $n = shift || 2;

show_vowels($n, "");

sub show_vowels {
    my($n, $str) = @_;
    if (length($str)==$n) {
        say $str;
    }
    elsif ($str eq "") {
        show_vowels($n, $str.$_) for (qw( a e i o u ));
    }
    elsif (substr($str, -1, 1) eq 'a') {
        show_vowels($n, $str.$_) for (qw( e i ));
    }
    elsif (substr($str, -1, 1) eq 'e') {
        show_vowels($n, $str.$_) for (qw( i ));
    }
    elsif (substr($str, -1, 1) eq 'i') {
        show_vowels($n, $str.$_) for (qw( a e o u ));
    }
    elsif (substr($str, -1, 1) eq 'o') {
        show_vowels($n, $str.$_) for (qw( a u ));
    }
    elsif (substr($str, -1, 1) eq 'u') {
        show_vowels($n, $str.$_) for (qw( e o ));
    }
    else {
        die;
    }
}
