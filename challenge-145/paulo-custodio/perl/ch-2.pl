#!/usr/bin/perl

# Challenge 145
#
# TASK #2 > Palindromic Tree
# Submitted by: Mohammad S Anwar
# You are given a string $s.
#
# Write a script to create a Palindromic Tree for the given string.
#
# I found this blog exaplaining Palindromic Tree in detail.
#
# Example 1:
# Input: $s = 'redivider'
# Output: r redivider e edivide d divid i ivi v
# Example 2:
# Input: $s = 'deific'
# Output: d e i ifi f c
# Example 3:
# Input: $s = 'rotors'
# Output: r rotor o oto t s
# Example 4:
# Input: $s = 'challenge'
# Output: c h a l ll e n g
# Example 5:
# Input: $s = 'champion'
# Output: c h a m p i o n
# Example 6:
# Input: $s = 'christmas'
# Output: c h r i s t m a

use Modern::Perl;

# https://rosettacode.org/wiki/Eertree#Perl
sub build_eertree {
    my($str) = @_;

    my @pal;
    for my $n (1 .. length($str)) {
        for my $m (1 .. length($str)-($n-1)) {
            my $strpal = substr($str, $n-1, $m);
            push @pal, $strpal if ($strpal eq reverse $strpal);
        }
    }

    my %seen;
    say join ' ', grep {not $seen{$_}++} @pal;
}

build_eertree(shift||"");
