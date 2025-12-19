#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 352 Task 2  Binary Prefix
#=============================================================================
# You are given an array, @nums, where each element is either 0 or 1.
# Define xi as the number formed by taking the first i+1 bits of @nums
# (from $nums[0] to $nums[i]) and interpreting them as a binary number,
# with $nums[0] being the most significant bit.
# For example: If @nums = (1, 0, 1), then:
#   x0 = 1 (binary 1)
#   x1 = 2 (binary 10)
#   x2 = 5 (binary 101)
#
# For each i, check whether xi is divisible by 5.
# Write a script to return an array @answer where $answer[i] is true if
#  x<sub>i</sub> is divisible by 5, otherwise false.
# Example 1
#    Input: @nums = (0,1,1,0,0,1,0,1,1,1)
#   Output: (true, false, false, false, false, true, true, false, false, false)
# Binary numbers formed (decimal values):
#          0: 0
#         01: 1
#        011: 3
#       0110: 6
#      01100: 12
#     011001: 25    (true)
#    0110010: 50    (true)
#   01100101: 101
#  011001011: 203
# 0110010111: 407
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

say join(", ", (map { $_ ? "true" : "false" } bpre(@ARGV)->@*) );

#=============================================================================
sub bpre(@nums)
{
    my @isFive;
    my $b = 0;

    while ( defined(my $bit = shift @nums) )
    {
        $b = ($b << 1) | $bit;
        push @isFive, ( $b % 5 == 0 );
    }
    return \@isFive;
}

sub runTest
{
    use Test2::V0;

    is( bpre( 0,1,1,0,0,1,0,1,1,1), 
            [ true, false, false, false, false, true, true, false, false, false ],
            , "Example 1");

    is( bpre(1,0,1,0,1,0),
            [ false, false, true, true, false, false ],
            , "Example 2");

    is( bpre(0,0,1,0,1),
            [ true, true, false, false, true ],
            , "Example 3");
        
    is( bpre(1,1,1,1,1),
            [ false, false, false, true, false ],
            , "Example 4");
        
    is( bpre(1,0,1,1,0,1,0,0,1,1),
            [ false, false, true, false, false, true, true, true, false, false ],
            , "Example 5");


    done_testing;
}
