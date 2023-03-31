#!/usr/bin/perl

# Challenge 179
#
# Task 1: Ordinal Number Spelling
# Submitted by: Mohammad S Anwar
#
# You are given a positive number, $n.
#
# Write a script to spell the ordinal number.
#
# For example,
#
# 11 => eleventh
# 62 => sixty-second
# 99 => ninety-ninth

use Modern::Perl;
use Number::Spell;

sub ordinal_number_spelling {
    my($n) = @_;
    my $str = spell_number($n);
    $str =~ s/twelve$/twelfth/ or
    $str =~ s/one$/first/ or
    $str =~ s/two$/second/ or
    $str =~ s/three$/third/ or
    $str =~ s/four$/forth/ or
    $str =~ s/five$/fifth/ or
    $str =~ s/eight$/eighth/ or
    $str =~ s/nine$/ninth/ or
    $str =~ s/y$/ieth/ or
    $str =~ s/$/th/;
    $str =~ s/ /-/g;
    return $str;
}

say ordinal_number_spelling(shift);
