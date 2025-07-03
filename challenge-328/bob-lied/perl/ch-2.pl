#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 328 Task 2  Good String
#=============================================================================
# You are given a string made up of lower and upper case English letters only.
# Write a script to return the good string of the given string. A string is
# called good string if it doesn’t have two adjacent same characters, one in
# upper case and other is lower case.
# Example 1 Input: $str = "WeEeekly"
#           Output: "Weekly"
#   We can remove either, "eE" or "Ee" to make it good.
# Example 2 Input: $str = "abBAdD"
#           Output: ""
#   We remove "bB" first: "aAdD".  Then we remove "aA": "dD" Finally remove "dD".
# Example 3 Input: $str = "abc"
#           Output: "abc"
#=============================================================================

use v5.40;


use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;
my $Benchmark = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose, "benchmark:i" => \$Benchmark);
my $logger;
{
    use Log::Log4perl qw(:easy);
    Log::Log4perl->easy_init({ level => ($Verbose ? $DEBUG : $INFO ),
            layout => "%d{HH:mm:ss.SSS} %p{1} %m%n" });
    $logger = Log::Log4perl->get_logger();
}
#=============================================================================

# Generate the regular expression "aA|Aa|bB|Bb|...|Zz"
my $ToBeRemoved = join("|", map { my $uc=uc($_); "$_$uc", "$uc$_" } 'a' .. 'z');

exit(!runTest()) if $DoTest;
exit( runBenchmark($Benchmark) ) if $Benchmark;

say enGooden($_) for @ARGV;

#=============================================================================
sub enGooden($str)
{
    while ( $str =~ s/$ToBeRemoved//g ) { }
    return $str;
}

sub runTest
{
    use Test2::V0;

    is( enGooden("WeEeekly"), "Weekly", "Example 1");
    is( enGooden("abBAdD"),   "",       "Example 2");
    is( enGooden("abc"),      "abc",    "Example 3");

    is( enGooden("xAadBbDyCczdD"), "xyz",   "upper-loeer combo");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}
