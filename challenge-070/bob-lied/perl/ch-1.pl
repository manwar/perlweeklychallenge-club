#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl
#=============================================================================
# Copyright (c) 2020, Bob Lied
#=============================================================================
# Perl Weekly Challenge 070 Task #1 > Character Swapping
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-070/
#
# You are given a string $S of size $N.
#
# You are also given swap count $C and offset $O such that $C >= 1, $O >= 1,
# $C <= $O and $C + $O <= $N.
# Write a script to perform character swapping like below:
# 
# $S[ 1 % $N ] <=> $S[ (1 + $O) % $N ]
# $S[ 2 % $N ] <=> $S[ (2 + $O) % $N ]
# $S[ 3 % $N ] <=> $S[ (3 + $O) % $N ]
# ...
# $S[ $C % $N ] <=> $S[ ($C + $O) % $N ]
# Example 1
#
# Input:
#    $S = 'perlandraku'
#          12345678901
#    $C = 3
#    $O = 4
#
# Character Swapping:
#    swap 1: e <=> n = pnrlaedraku
#    swap 2: r <=> d = pndlaerraku
#    swap 3: l <=> r = pndraerlaku
#
# Output:
#    pndraerlaku
#=============================================================================

use strict;
use warnings;
use v5.10;

sub Usage
{
    return join("\n\t",
             "Usage: swap STRING COUNT OFFSET"
            ,"1 <= COUNT <= OFFSET"
            ,"(COUNT+OFFSET) <= length(STRING)"
            ,"Example: swap perlandraku 3 4"
        );
}

do { say Usage; exit 1 } unless scalar(@ARGV) == 3;

my ($string, $count, $offset) = @ARGV;

my $len = length($string);

do { say "OFFSET out of range", Usage; exit 2 } unless $offset < $len;
do { say "COUNT out of range", Usage; exit 2 } unless 1 <= $count && $count <= $offset;

# Brute force according to specification
sub swap
{
    my ($str, $cnt, $off) = @_;
    my $len = length($str);

    for my $p ( 1..$cnt )
    {
        my $j = ($p % $len);
        my $k = (($p + $off) % $len);

        my $t = substr($str, $j, 1);
        substr($str, $j, 1) = substr($str, $k, 1);
        substr($str, $k, 1) = $t;
    }
    return $str;
}

# Swapping the entire substring at once
sub swap2
{
    my ($str, $cnt, $off) = @_;
    my $len = length($str);

    my $to   = substr($str, 1, $cnt);
    my $from = substr($str, $off+1, $cnt);

    return substr($str, 0, 1) . $from
         . substr($str, $cnt+1, $off - $cnt)
         . $to
         . substr($str, $off+$cnt+1)
         ;
}

# Convert to array and use array operations
sub swap3
{
    my ($str, $cnt, $off) = @_;
    my $len = length($str);

    my @str = split(//, $str);
    my @from = @str[ 1 .. $cnt+1 ];

    @str[1 .. $cnt+1] = @str[$off+1 .. $off+$cnt+1];
    @str[$off+1 .. $off+$cnt+1] = @from;

    # Would splice be any better?

    return join("", @str);
}

say swap('perlandraku', 3, 4);
say swap2('perlandraku', 3, 4);
say swap3('perlandraku', 3, 4);
