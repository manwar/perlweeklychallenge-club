#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 368 Task 2  Big and Little Omega
#=============================================================================
# You are given a positive integer $number and a mode flag $mode.
# If the mode flag is zero, calculate little omega (the count of all
# distinct prime factors of that number). If it is one, calculate big
# omega (the count of all prime factors including duplicates).
# Example 1 Input: $number = 100061 $mode = 0
#			Output: 3
#   Prime factors are 13, 43, 179. Count is 3.
# Example 2 Input: $number = 971088 $mode = 0
#			Output: 3
#   Prime factors are 2, 2, 2, 2, 3, 20231. Count of distinct numbers is 3.
# Example 3 Input: $number = 63640 $mode = 1
#			Output: 6
#   Prime factors are 2, 2, 2, 5, 37, 43. Count including duplicates is 6.
# Example 4 Input: $number = 988841 $mode = 1
#			Output: 2
# Example 5 Input: $number = 211529 $mode = 0
#			Output: 2
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

say omega(@ARGV);

#=============================================================================
sub omega($number, $mode)
{
    use Math::Prime::Util qw/factor/;
    use List::Util qw/uniq/;

    my @factor = factor($number);
    $logger->debug("Prime factors: (", scalar(@factor), ") @factor");
    return scalar ( $mode ? @factor : uniq(@factor) );
}

sub runTest
{
    use Test2::V0;

    is( omega(100061, 0), 3, "Example 1");
    is( omega(971088, 0), 3, "Example 2");
    is( omega( 63640, 1), 6, "Example 3");
    is( omega(988841, 1), 2, "Example 4");
    is( omega(211529, 0), 2, "Example 5");

    is( omega(     0, 0), 1, "Degenerate case: 0");
    is( omega(     1, 0), 0, "Degenerate case: 1");
    is( omega(   127, 0), 1, "Prime number 0");
    is( omega(   127, 1), 1, "Prime number 1");

    done_testing;
}
