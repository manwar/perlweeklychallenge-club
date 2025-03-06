#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 311 Task 2 Group Digit Sum
#=============================================================================
# You are given a string, $str, made up of digits, and an integer, $int,
# which is less than the length of the given string.
# Write a script to divide the given string into consecutive groups of
# size $int (plus one for leftovers if any). Then sum the digits of each
# group, and concatenate all group sums to create a new string. If the length
# of the new string is less than or equal to the given integer then return
# the new string, otherwise continue the process.
# Example 1 Input: $str = "111122333", $int = 3
#           Output: "359"
#   Step 1: "111", "122", "333" => "359"
# Example 2 Input: $str = "1222312", $int = 2
#           Output: "76"
#   Step 1: "12", "22", "31", "2" => "3442"
#   Step 2: "34", "42" => "76"
# Example 3 Input: $str = "100012121001", $int = 4
#           Output: "162"
#   Step 1: "1000", "1212", "1001" => "162"
#=============================================================================

use v5.40;
use List::Util qw/sum/;

use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
my $logger;
{
    use Log::Log4perl qw(:easy);
    Log::Log4perl->easy_init({ level => ($Verbose ? $DEBUG : $INFO ),
            layout => "%d{HH:mm:ss.SSS} %p{1} %m%n" });
    $logger = Log::Log4perl->get_logger();
}
#=============================================================================

exit(!runTest()) if $DoTest;

my $STR = $ARGV[0] =~ tr/0-9//cdr;
my $N   = $ARGV[1] // 2;
say groupDigitSum($STR, $N);

#=============================================================================
sub groupDigitSum($str, $n)
{
    while ( length($str) > $n )
    {
        if ( $Verbose )
        {
            $str = mangle_V($str, $n);
        }
        else
        {
            # $str = mangle($str, $n);
            $str = join "", map { sum( split("", $_) ) } unpack("(a$n)*", $str);
        }
    }
    return $str;

    sub mangle($str, $n)
    {
        return join "", map { sum( split(//, $_) ) } ($str =~ m/(.{1,$n})/g);
    }

    sub mangle_V($str, $n)
    {
        my @grp = $str =~ m/(.{1,$n})/g;
        my @sum = map { sum( split(//, $_)) } @grp;
        $logger->info("$str => @grp => @sum");
        return join("", @sum);
    }
}

sub runTest
{
    use Test2::V0;

    is( groupDigitSum(   "111122333", 3), 359, "Example 1");
    is( groupDigitSum(     "1222312", 2),  76, "Example 2");
    is( groupDigitSum("100012121001", 4), 162, "Example 3");

    done_testing;
}
