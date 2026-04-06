#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 368 Task 1  Make it Bigger
#=============================================================================
# You are given a given a string number and a character digit.
# Write a script to remove exactly one occurrence of the given character
# digit from the given string number, resulting the decimal form is maximised.
# Example 1 Input: $str = "15456", $char = "5"
#			Output: "1546"
#   Removing the second "5" is better because the digit following it (6) is
#   greater than 5. In the first case, 5 was followed by 4 (a decrease),
#   which makes the resulting number smaller.
#
# Example 2 Input: $str = "7332", $char = "3"
#			Output: "732"
# Example 3 Input: $str = "2231", $char = "2"
#			Output: "231"
#   Removing either "2" results in the same string here. By removing a "2",
#   we allow the "3" to move up into a higher decimal place.
#
# Example 4 Input: $str = "543251", $char = "5"
#			Output: "54321"
#   If we remove the first "5", the number starts with 4. If we remove the
#   second "5", the number still starts with 5. Keeping the largest possible
#   digit in the highest place value is almost always the priority.
#
# Example 5 Input: $str = "1921", $char = "1"
#			Output: "921"
#=============================================================================

use v5.42;


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

say embiggen(@ARGV);

#=============================================================================
sub embiggen($str, $c)
{
    use List::AllUtils qw/max indexes/;

    my @place = indexes { $_ eq $c } split(//, $str);
    my @rmvd  = map { my $s = $str; substr($s, $_, 1, ""); $s } @place;
    return max(@rmvd) // $str;
    
    #return (max map { my $s = $str; substr($s, $_, 1, ""); $s }
    #        indexes { $_ eq $c } split(//, $str) ) // $str;
}

sub runTest
{
    use Test2::V0;

    is( embiggen( "15456", "5"),  1546, "Example 1");
    is( embiggen(  "7332", "3"),   732, "Example 2");
    is( embiggen(  "2231", "2"),   231, "Example 3");
    is( embiggen("543251", "5"), 54321, "Example 4");
    is( embiggen(  "1921", "1"),   921, "Example 5");

    is( embiggen(  "1234", "9"),  1234, "c not found");
    is( embiggen(  "0023", "2"), "003", "leading zero");

    done_testing;
}
