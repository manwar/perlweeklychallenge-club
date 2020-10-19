#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl
#=============================================================================
# Copyright (c) 2020, Bob Lied
#=============================================================================
# Perl Weekly Challenge 082 Task #1 > Common Factors
#=============================================================================
# Your are given two positive numbers, $M and $N.
# Write a script to list all common factors of the given numbers

use strict;
use warnings;
use v5.30;

use feature qw/ signatures /;
no warnings qw/ experimental::signatures /;

use Getopt::Long;

sub Usage { "Usage: $0 M N" };

my $Verbose = 0;
GetOptions('verbose' => \$Verbose);

my ($M, $N) = @ARGV;

die Usage() unless $M && $N;
die Usage() unless $M > 0 && $N > 0;

sub factor($n)
{
    my $f = 2;
    my %factor = (1 => 1, $n => 1);
    my $sqrtf = int(sqrt($n));
    while ( $f <= $sqrtf )
    {
        if ( ($n % $f) == 0 )
        {
            my $otherf = $n / $f;
            $factor{$f} = $factor{$otherf} = 1;
        }
        $f++;
    }

    return sort { $a <=> $b } keys %factor;
}

sub both($m, $n)
{
    my (%union, %intersection);
    foreach my $e ( @$m, @$n)
    {
        $union{$e}++ && $intersection{$e}++;
    }
    return sort { $a <=> $b } keys %intersection;
}

my @fM = factor($M);
my @fN = factor($N);

my @same = both(\@fM, \@fN);

say "(", join(", ", @same), ")";
