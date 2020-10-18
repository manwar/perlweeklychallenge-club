#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl
#=============================================================================
# Copyright (c) 2020, Bob Lied
#=============================================================================
# Perl Weekly Challenge 082 Task #2 > Interleave String
#=============================================================================
# You are given 3 strings; $A, $B and $C.
# Write a script to check if $C is created by interleave $A and $B.
# Print 1 if check is success otherwise 0.
#
# Example 1: Input: $A = "XY" $B = "X" $C = "XXY"
# Output: 1
# EXPLANATION
# "X" (from $B) + "XY" (from $A) = $C
#
# Example 2: Input: $A = "XXY" $B = "XXZ" $C = "XXXXZY"
# Output: 1
# EXPLANATION
# "XX" (from $A) + "XXZ" (from $B) + "Y" (from $A) = $C
#
# Example 3:
# Input: $A = "YX" $B = "X" $C = "XXY"
# Output: 0

use strict;
use warnings;
use v5.30;

use feature qw/ signatures /;
no warnings qw/ experimental::signatures /;

use Getopt::Long;

sub Usage { "Usage: $0 strA strB strC" };

my $Verbose = 0;
GetOptions('verbose' => \$Verbose);

my ($A, $B, $C) = @ARGV;

die Usage() unless $A && $B && $C;

sub inter($s, $t, $c, $depth)
{
    #say "$depth: Enter [@$s] [@$t] [@$c]";
    # For each prefix of s that matches c
    my $longestPrefix = 0;
    my $lenS = $#$s;
    my $lenC = $#$c;
    for ( my $i = 0;  $i <= $lenS && $i <= $lenC && $s->[$i] eq $c->[$i] ; $i++ )
    {
        $longestPrefix++;
    }
    return 0 unless $longestPrefix;
    my $lastS = $#{$s};
    my $lastC = $#{$c};
    for my $len ( 1 .. $longestPrefix )
    {
        #say "depth: Try  s[0..$len] = '", join("", @{$s}[0..$len-1]), "' against [@$c]";
        my @shorterS = ( @{$s}[ $len .. $lastS ] );
        my @shorterC = ( @{$c}[ $len .. $lastC ] );

        return 1 if ( ! @shorterC );

        # Swap strings to check for interleaving
        return 1 if inter($t, \@shorterS, \@shorterC, $depth+1);
    }
    return 0;
}

my @A = split "", $A;
my @B = split "", $B;
my @C = split "", $C;

say inter(\@A, \@B, \@C, 0) || inter(\@B, \@A, \@C, 0);
