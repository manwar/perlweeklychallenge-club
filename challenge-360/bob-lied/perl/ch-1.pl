#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 360 Task 1  Text Justifier
#=============================================================================
# You are given a string and a width.  Write a script to return the string
# that centers the text within that width using asterisks * as padding.
# Example 1 Input: $str = "Hi", $width = 5
#			Output: "*Hi**"
# Example 2 Input: $str = "Code", $width = 10
#			Output: "***Code***"
# Example 3 Input: $str = "Hello", $width = 9
#			Output: "**Hello**"
# Example 4 Input: $str = "Perl", $width = 4
#			Output: "Perl"
# Example 5 Input: $str = "A", $width = 7
#			Output: "***A***"
#=============================================================================

use v5.42;


use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;
my $Width = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose, "width:i" => \$Width);
my $logger;
{
    use Log::Log4perl qw(:easy);
    Log::Log4perl->easy_init({ level => ($Verbose ? $DEBUG : $INFO ),
            layout => "%d{HH:mm:ss.SSS} %p{1} %m%n" });
    $logger = Log::Log4perl->get_logger();
}
#=============================================================================

exit(!runTest()) if $DoTest;

say center($_, $Width) for @ARGV;

#=============================================================================
sub center($str, $width, $fill = '*')
{
    my $len = length($str);
    return $str if $len >= $width;

    my $left  = $fill x floor(($width - $len) / 2);
    my $right = $fill x  ceil(($width - $len) / 2);
    return "$left$str$right";
}

sub runTest
{
    use Test2::V0;

    is( center("Hi",    5), "*Hi**",      "Example 1");
    is( center("Code", 10), "***Code***", "Example 2");
    is( center("Hello", 9), "**Hello**",  "Example 3");
    is( center("Perl",  4), "Perl",       "Example 3");
    is( center("A",     7), "***A***",    "Example 5");

    done_testing;
}

