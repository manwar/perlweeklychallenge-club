#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl Perl Weekly Challenge 224 Task 2 Additive Number
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given a string containing digits 0-9 only.
# Write a script to find out if the given string is additive number.
# An additive number is a string whose digits can form an additive sequence.
#
# A valid additive sequence should contain at least 3 numbers. Except the
# first 2 numbers, each subsequent number in the sequence must be the sum
# of the preceding two.
#
# Example 1: Input: $string = "112358"
#           Output: true
#   The additive sequence can be created using the string digits: 1,1,2,3,5,8
#   1 + 1 => 2
#   1 + 2 => 3
#   2 + 3 => 5
#   3 + 5 => 8
#
# Example 2: Input: $string = "12345"
#           Output: false
#   No additive sequence can be created using the given string digits.
#
# Example 3: Input: $string = "199100199"
#           Output: true
#   The additive sequence can be created using the string digits: 1,99,100,199
#    1 +  99 => 100
#   99 + 100 => 199
#=============================================================================

use v5.36;
use experimental qw/builtin/; use builtin qw/true false/;
use Feature::Compat::Class;

class SubStr
{
    field $str :param //= "0";
    field $beg :param //= 0;
    field $end :param //= 0;
    field $len :param //= 1;

    ADJUST { $len = $end - $beg + 1 }

    method end { return $end }
    method val { substr($str, $beg, $len); }

    method extend { $end++; $len++; }

    method show { "[$beg-$end]=" . substr($str, $beg, $len) }
}

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;


foreach ( @ARGV )
{
    say additiveNumber($_) if /\d+/;
}

sub canSum($str, $t1, $t2)
{
    my $longest2 = $t2->end + ((length($str) - $t2->end) / 2);
    while ( $t2->end < $longest2 )
    {
        my $sum = $t1->val + $t2->val;
        my $inStr = substr($str, $t2->end + 1, length($sum) );

        printf("canSum: t1=%s t2=%s sum=$sum instr=$inStr\n", $t1->show, $t2->show) if $Verbose;

        if ( $sum eq $inStr )
        {
            return SubStr->new(str=> $str, beg=> $t2->end + 1,
                               end=> $t2->end + length($sum) );
        }
        else
        {
            $t2->extend();
        }
    }
    return false;
}

sub additiveNumber($str)
{
    my $lastPosInStr = length($str) - 1;
    return "false" if $lastPosInStr < 2;

    my $t1 = SubStr->new(str => $str, beg => 0, end => 0);
    FIRSTTERM:
    while ( $t1->end <= $lastPosInStr / 3 )
    {
        my $t2 = SubStr->new(str => $str, beg => $t1->end+1, end => $t1->end+1);
        printf("TRY t1=%s t2=%s\n", $t1->show, $t2->show) if $Verbose;

        my $pos = $t2->end;
        while ( $pos < $lastPosInStr )
        {
            if ( my $s = canSum($str, $t1, $t2) )
            {
                $pos = $s->end;
                $t1 = $t2;
                $t2 = $s;
                say "str='$str' last=$lastPosInStr pos=$pos" if $Verbose;
            }
            else
            {
                $t1->extend();
                next FIRSTTERM;
            }
        }
        if ( $pos == $lastPosInStr )
        {
            return "true";
        }
    }
    return "false";
}

sub runTest
{
    use Test2::V0;

    is( additiveNumber("9"),         "false", "Too small 1");
    is( additiveNumber("12"),        "false", "Too small 2");
    is( additiveNumber("127"),       "false", "Obvious fail");
    is( additiveNumber("112358"),     "true", "Example 1");
    is( additiveNumber("12345" ),    "false", "Example 2");
    is( additiveNumber("199100199"),  "true", "Example 3");
    is( additiveNumber("1123581321345589144"), "true", "Fibonacci");
    is( additiveNumber("11235913"),   "true", "Fail fib");

    done_testing;
}
