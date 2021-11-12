#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl
#=============================================================================
# Copyright (c) 2021, Bob Lied
#=============================================================================
# Perl Weekly Challenge, Week 138, TASK #2 › Split Number
# You are given a perfect square.  Write a script to figure out if the square
# root the given number is same as sum of 2 or more splits of the given number.  #=============================================================================

use strict;
use warnings;
use v5.32;

use experimental qw/ signatures /;
no warnings "experimental::signatures";

use List::Util;
use Data::Dumper;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

my $N = shift;

sub _splitN($prefix, $rest, $sqrtN, $depth, $splits)
{
    my $tab = " " x ($depth*4); # Debugging aid
    my $len = length $rest;
    for my $p ( 1 .. ($len-1) )
    {
        my $pre  = substr($rest, 0, $p);
        my $rest = substr($rest, $p);
        say STDERR "$tab [ $prefix ][ $pre ][ $rest ]" if $Verbose;
        my $split = [ $prefix, $pre, $rest ];
        push @$splits, $split;
        return 1 if List::Util::sum(@$split) == $sqrtN ||
            _splitN("$prefix$pre", $rest, $sqrtN, $depth+1, $splits) == 1;

    }
}

sub splitNumber($n)
{
    my $sqrtN = sqrt($n);
    my @splits;
    my $len = length($n);
    for my $p ( 1 .. ($len-1) )
    {
        my $prefix = substr($n, 0, $p);
        my $rest   = substr($n, $p);
        push @splits, [ $prefix, $rest ];
        say STDERR "[ $prefix ][ $rest ]" if $Verbose;
        return 1 if ( ($prefix + $rest) == $sqrtN ) ||
            _splitN($prefix, $rest, $sqrtN, 1, \@splits) == 1;

    }
    if ( $Verbose ) { say "@$_" for @splits; }
    return 0;
}

say splitNumber($N);

#for my $n ( map { $_*$_ } ( 4..100 ) )
#{ 
#    say "$n (", sqrt($n), ") ", splitNumber($n);
#}

sub runTest
{
    use Test::More;

    is(splitNumber(   25), 0, "N =    25,   5 = __");
    is(splitNumber(   81), 1, "N =    81,   9 =   8 +  1");
    is(splitNumber(  100), 1, "N =   100,  10 =  10 +  0 + 0");
    is(splitNumber(  484), 0, "N =   484,  22 =  __");
    is(splitNumber( 1296), 1, "N =  1296,  36 =   1 + 29 + 6");
    is(splitNumber( 4900), 0, "N =  4900,  70 =  __");
    is(splitNumber( 9801), 1, "N =  9810,  99 =  98 +  1 + 0");
    is(splitNumber(10000), 1, "N = 10000, 100 = 100 +  0 + 0");

    done_testing;
}

