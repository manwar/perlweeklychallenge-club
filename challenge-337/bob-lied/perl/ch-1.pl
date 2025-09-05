#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 337 Task 1  Smaller Than Current
#=============================================================================
# You are given an array of numbers, @num1.  Write a script to return an
# array, @num2, where $num2[i] is the count of all numbers less than or
# equal to $num1[i].
# Example 1 Input: @num1 = (6, 5, 4, 8)
#           Output: (2, 1, 0, 3)
#   index 0: numbers <= 6 are 5, 4    => 2
#   index 1: numbers <= 5 are 4       => 1
#   index 2: numbers <= 4, none       => 0
#   index 3: numbers <= 8 are 6, 5, 4 => 3
# Example 2 Input: @num1 = (7, 7, 7, 7)
#           Output: (3, 3, 3, 3)
# Example 3 Input: @num1 = (5, 4, 3, 2, 1)
#           Output: (4, 3, 2, 1, 0)
# Example 4 Input: @num1 = (-1, 0, 3, -2, 1)
#           Output: (1, 2, 4, 0, 3)
# Example 5 Input: @num1 = (0, 1, 1, 2, 0)
#           Output: (1, 3, 3, 4, 1)
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

say "(", join(", ", stc(@ARGV)->@*), ")";

#=============================================================================
sub stc(@int)
{
    my @sorted = sort { $a <=> $b } @int;
    my %smaller;
    for  my ($i, $n) ( indexed @sorted )
    {
        $smaller{$n} = $i;
    }
    return [ @smaller{@int} ];
}

sub runTest
{
    use Test2::V0;

    is( stc(6,5,4,8),     [2,1,0,3],   "Example 1");
    is( stc(7,7,7,7),     [3,3,3,3],   "Example 2");
    is( stc(5,4,3,2,1),   [4,3,2,1,0], "Example 3");
    is( stc(-1,0,3,-2,1), [1,2,4,0,3], "Example 4");
    is( stc(0,1,1,2,0),   [1,3,3,4,1], "Example 5");

    is( stc(), [], "Empty list");
    is( stc(9), [0], "Singleton list");

    done_testing;
}
