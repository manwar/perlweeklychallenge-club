#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 347 Task 2  Format Phone Number
#=============================================================================
# You are given a phone number as a string containing digits, space and dash only.
# Write a script to format the given phone number using the below rules:
# 1. Removing all spaces and dashes
# 2. Grouping digits into blocks of length 3 from left to right
# 3. Handling the final digits (4 or fewer) specially:
#    - 2 digits: one block of length 2
#    - 3 digits: one block of length 3
#    - 4 digits: two blocks of length 2
# 4. Joining all blocks with dashes
#
# Example 1 Input: $phone = "1-23-45-6"
#           Output: "123-456"
# Example 2 Input: $phone = "1234"
#           Output: "12-34"
# Example 3 Input: $phone = "12 345-6789"
#           Output: "123-456-789"
# Example 4 Input: $phone = "123 4567"
#           Output: "123-45-67"
# Example 5 Input: $phone = "123 456-78"
#           Output: "123-456-78"
#=============================================================================

use v5.42;


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

exit(!runTest()) if $DoTest;
exit( runBenchmark($Benchmark) ) if $Benchmark;

say fmtPhone($_) for @ARGV;

#=============================================================================
sub fmtPhone($phone)
{
    my $fmt = "";
    $phone =~ s/[^0-9]//g;

    my @p = $phone =~ m/(\d{1,3})/g;
    if ( length($p[-1]) == 1 && @p > 1 )
    {
        (my $tail = "$p[-2]$p[-1]") =~ s/(..)(..)/$1-$2/;
        splice(@p, -2, 2, $tail);
    }
    return join('-', @p);
}


sub runTest
{
    use Test2::V0;

    is( fmtPhone(  "1-23-45-6"), "123-456"     , "Example 1");
    is( fmtPhone(       "1234"), "12-34"       , "Example 2");
    is( fmtPhone("12 345-6789"), "123-456-789" , "Example 3");
    is( fmtPhone(   "123 4567"), "123-45-67"   , "Example 4");
    is( fmtPhone( "123 456-78"), "123-456-78"  , "Example 5");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}

