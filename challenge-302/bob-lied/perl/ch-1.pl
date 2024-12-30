#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 302 Task 1 Ones and Zeroes
#=============================================================================
# You are given an array of binary strings, @str, and two integers, $x and $y.
# Write a script to return the size of the largest subset of @str such that
# there are at most $x 0’s and $y 1’s in the subset.
# A set m is a subset of n if all elements of m are also elements of n.
# Example 1 Input: @str = ("10", "0001", "111001", "1", "0")
#                  $x = 5 $y = 3
#           Output: 4
#   The largest subset with at most five 0's and three 1's: ("10", "0001", "1", "0")
# Example 2 Input: @str = ("10", "1", "0")
#                  $x = 1 $y = 1
#           Output: 2
#   The largest subset with at most one 0's and one 1's: ("1", "0")
#=============================================================================

use v5.40;

use Getopt::Long;
my $Verbose = false; my $logger;
my $DoTest  = false;

my $X = 0;
my $Y = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose,
           "x:i" => \$X, "y:i" => \$Y);
if ( $Verbose )
{
    use Log::Log4perl qw(:easy);
    $logger = Log::Log4perl->get_logger();
    Log::Log4perl->easy_init({ level => $DEBUG,
                               layout => "%d{HH:mm:ss.SSS} %p{1} %m%n" });
}
exit(!runTest()) if $DoTest;

say onesAndZeroes({x=>$X, y=>$Y, str=>[@ARGV]});

sub onesAndZeroes($param)
{
    use Algorithm::Combinatorics qw/combinations/;

    my ($x, $y, $str)  = $param->@{qw(x y str)};
    $logger->debug("x=$x y=$y str=[@$str]");

    my $most = 0;
    COMBO: for my $k ( reverse 1 .. scalar(@$str) )
    {
        my $combIter = combinations($str, $k);
        while ( my $comb = $combIter->next() )
        {
            my @zo = countBits( join("", $comb->@*) );
            $logger->debug("k=$k zo=[@zo] comb=[@$comb]");
            if ( $zo[0] <= $x && $zo[1] <= $y )
            {
                $most = $k;
                last COMBO;
            }
        }
    }
    return $most;
}

sub countBits($bv)
{
    my $len = length($bv);
    my $one = ($bv =~ tr/1/1/);
    my $zero = $len - $one;
    return ($zero, $one);
}

sub runTest
{
    use Test2::V0;

    my @bitCountTest = (
        [ "00000000", 8, 0, "all 0" ],
        [ "10000000", 7, 1, "leading 1" ],
        [ "00000001", 7, 1, "trailing 1" ],
        [ "00010000", 7, 1, "middle 1" ],
        [ "01010100", 5, 3, "multiple 1" ],
        [ "11111111", 0, 8, "all 1" ],
    );
    for ( @bitCountTest )
    {
        my @zo = countBits($_->[0]);
        ok ( $zo[0] == $_->[1] && $zo[1] == $_->[2], "countBits $_->[3]");
    }


    is( onesAndZeroes({ x=>5, y=>3, str=>[ qw(10 0001 111001 1 0) ] }),
                        4, "Example 1");
    is( onesAndZeroes({ x=>1, y=>1, str=>[ qw(10 1 0) ] }),
                        2, "Example 2");

    done_testing;
}

