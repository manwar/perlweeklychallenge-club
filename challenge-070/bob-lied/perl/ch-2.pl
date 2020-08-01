#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl
#=============================================================================
# Copyright (c) 2020, Bob Lied
#=============================================================================
# Perl Weekly Challenge 070 Task #2 > Gray Code Sequence
#
# You are given an integer 2<=N <= 5.
# Write a script to generate $N-bit Gray code sequence.
#=============================================================================

use strict;
use warnings;
use v5.10;

sub Usage
{
    return join("\n\t", "Usage: gray N", '2 <= N <= 5');
}

do { say Usage() } unless scalar(@ARGV) == 1;

my $N = $ARGV[0];
do { say "Out of range", Usage; } unless 2 <= $N && $N <= 5;

sub graycode
{
    my ($n) = @_;

    my @code = ( 0, 1 );

    while ( $n-- > 1 )
    {
        my $hibit = scalar(@code);    # Power of 2
        @code = ( @code, map { $hibit | $_  } reverse @code );
    }
    return @code;
}

printf("%3d %${N}b\n", $_, $_) for graycode($N);
