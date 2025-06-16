#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 325 Task 2  Final Price
#=============================================================================
# You are given an array of item prices.  Write a script to find out the
# final price of each items in the given array, under the following odd rule:
#
# There is a special discount scheme going on. If there’s an item with a
# lower or equal price later in the list, you get a discount equal to that
# later price (the first one you find in order).
#
# Example 1 Input: @prices = (8, 4, 6, 2, 3)
#           Output: (4, 2, 4, 2, 3)
#   Item 0: The item price is 8.
#       The first time that has price <= current item price is 4.
#       Final price = 8 - 4 => 4
#   Item 1: The item price is 4.
#       The first time that has price <= current item price is 2.
#       Final price = 4 - 2 => 2
#   Item 2: The item price is 6.
#       The first time that has price <= current item price is 2.
#       Final price = 6 - 2 => 4
#   Item 3: The item price is 2.
#       No item has price <= current item price, no discount.
#       Final price = 2
#   Item 4: The item price is 3.
#       Since it is the last item, so no discount.
#       Final price = 3
#
# Example 2 Input: @prices = (1, 2, 3, 4, 5)
#           Output: (1, 2, 3, 4, 5)
# Example 3 Input: @prices = (7, 1, 1, 5)
#           Output: (6, 0, 1, 5)
#=============================================================================

use v5.40;
use List::Util qw/first/;


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

say '(', join(', ', finalPrice(@ARGV)), ')';

#=============================================================================
sub finalPrice(@prices)
{
    my @final;
    while ( defined(my $p = shift @prices) )
    {
        push @final, $p - (( first { $_ <= $p } @prices ) // 0);
    }
    return @final;
}

sub runTest
{
    use Test2::V0;

    is( [finalPrice(8,4,6,2,3)], [4,2,4,2,3], "Example 1");
    is( [finalPrice(1,2,3,4,5)], [1,2,3,4,5], "Example 2");
    is( [finalPrice(7,1,1,5  )], [6,0,1,5  ], "Example 3");

    done_testing;
}
