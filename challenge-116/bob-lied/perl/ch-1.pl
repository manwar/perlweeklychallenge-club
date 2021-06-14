#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl
#=============================================================================
# Copyright (c) 2021, Bob Lied
#=============================================================================
# Perl Weekly Challenge 116, Task #1 Number Sequence 
# You are given a number $N >= 10.
# Write a script to split the given number such that the difference between
# two consecutive numbers is always 1 and it shouldn’t have leading 0.
# Print the given number if it impossible to split the number.
# Example
# Input: $N = 1234  Output: 1,2,3,4
# Input: $N = 91011 Output: 9,10,11
# Input: $N = 10203 Output: 10203 as it is impossible to split satisfying the conditions.
#=============================================================================

use strict;
use warnings;
use v5.30;

use experimental qw/ signatures /;
no warnings "experimental::signatures";

sub usage() { "Usage: $0 N, N>=10" };

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);

my $N = shift;
die usage() unless defined $N && $N >= 10;

exit(!runTest()) if $DoTest;

sub seqUpToLen($first, $maxLen)
{
    my @seq = ( $first );
    my $str = $first;
    while ( length($str) < $maxLen )
    {
        push @seq, ++$first;
        $str .= $first
    }
    return \@seq;
}

sub numberSequence($N)
{
    # Generate prefixes of every useful length from N.
    # The longest prefix we need is half the string.
    for my $n ( 1 .. int(length($N)/2) )
    {
        my $p = substr($N, 0, $n);
        say $p;

        # Generate the seqence starting from p, making the
        # number as long as N
        my $seq = seqUpToLen($p, length($N));
        my $str = join("", @$seq);
        say "p=$p seq=(@$seq) $str";

        if ( $str eq $N )
        {
            return join(",", @$seq);
        }
    }
    return $N;
}

sub runTest
{
    use Test::More;

    is_deeply(seqUpToLen(1, 2), [ 1, 2 ], "seqUpToLen 1 2");
    is_deeply(seqUpToLen(1, 4), [ 1, 2, 3, 4 ], "seqUpToLen 1 4");
    is_deeply(seqUpToLen(11, 5), [ 11, 12, 13 ], "seqUpToLen 11 5");

    is(numberSequence(1234), "1,2,3,4", "N=1234");
    is(numberSequence(91011), "9,10,11", "N=91011");
    is(numberSequence(10203), "10203", "N=10203");

    done_testing;
}

