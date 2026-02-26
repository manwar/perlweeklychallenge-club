#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 361 Task 2  Find Celebrity
#=============================================================================
# You are given a binary matrix (m x n).  Write a script to find the
# celebrity, return -1 when none found.  A celebrity is someone, everyone
# knows and knows nobody.
# 
# Example 1 Input: @party = ( [0, 0, 0, 0, 1, 0],  # 0 knows 4
#                             [0, 0, 0, 0, 1, 0],  # 1 knows 4
#                             [0, 0, 0, 0, 1, 0],  # 2 knows 4
#                             [0, 0, 0, 0, 1, 0],  # 3 knows 4
#                             [0, 0, 0, 0, 0, 0],  # 4 knows NOBODY
#                             [0, 0, 0, 0, 1, 0],  # 5 knows 4 );
#			Output: 4
# Example 2 Input: @party = ( [0, 1, 0, 0],  # 0 knows 1
#                             [0, 0, 1, 0],  # 1 knows 2
#                             [0, 0, 0, 1],  # 2 knows 3
#                             [1, 0, 0, 0]   # 3 knows 0 );
#			Output: -1
# Example 3 Input: @party = ( [0, 0, 0, 0, 0],  # 0 knows NOBODY
#                             [1, 0, 0, 0, 0],  # 1 knows 0
#                             [1, 0, 0, 0, 0],  # 2 knows 0
#                             [1, 0, 0, 0, 0],  # 3 knows 0
#                             [1, 0, 0, 0, 0]   # 4 knows 0 );
#			Output: 0
# Example 4 Input: @party = ( [0, 1, 0, 1, 0, 1],  # 0 knows 1, 3, 5
#                             [1, 0, 1, 1, 0, 0],  # 1 knows 0, 2, 3
#                             [0, 0, 0, 1, 1, 0],  # 2 knows 3, 4
#                             [0, 0, 0, 0, 0, 0],  # 3 knows NOBODY
#                             [0, 1, 0, 1, 0, 0],  # 4 knows 1, 3
#                             [1, 0, 1, 1, 0, 0]   # 5 knows 0, 2, 3 );
#			Output: 3
# Example 5 Input: @party = ( [0, 1, 1, 0],  # 0 knows 1 and 2
#                             [1, 0, 1, 0],  # 1 knows 0 and 2
#                             [0, 0, 0, 0],  # 2 knows NOBODY
#                             [0, 0, 0, 0]   # 3 knows NOBODY );
#			Output: -1
# Example 6 Input: @party = ( [0, 0, 1, 1],  # 0 knows 2 and 3
#                             [1, 0, 0, 0],  # 1 knows 0
#                             [1, 1, 0, 1],  # 2 knows 0, 1 and 3
#                             [1, 1, 0, 0]   # 3 knows 0 and 1 );
#			Output: -1
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

say $_ for @ARGV;   # TODO command line processing here

#=============================================================================
sub celebrity($party)
{
    use List::Util qw/all/;
    for my $row ( 0 .. $party->$#* )
    {
        if ( all { $_ == 0 } $party->[$row]->@* )
        {
            my @other = grep { $_ != $row } 0 .. $party->$#*;
            my @know = map { $_->[$row] } $party->@[@other];
            return $row if all { $_ == 1 } @know;
        }
    }
    return -1;
}

sub runTest
{
    use Test2::V0;

    my @party;
    @party = ( [0, 0, 0, 0, 1, 0],    # 0 knows 4
               [0, 0, 0, 0, 1, 0],    # 1 knows 4
               [0, 0, 0, 0, 1, 0],    # 2 knows 4
               [0, 0, 0, 0, 1, 0],    # 3 knows 4
               [0, 0, 0, 0, 0, 0],    # 4 knows NOBODY
               [0, 0, 0, 0, 1, 0], ); # 5 knows 4
    is( celebrity(\@party), 4, "Example 1");

    @party = ( [0, 1, 0, 0],   # 0 knows 1
              [0, 0, 1, 0],    # 1 knows 2
              [0, 0, 0, 1],    # 2 knows 3
              [1, 0, 0, 0], ); # 3 knows 0
    is( celebrity(\@party), -1, "Example 2");

    @party = ( [0, 0, 0, 0, 0],   # 0 knows NOBODY
              [1, 0, 0, 0, 0],    # 1 knows 0
              [1, 0, 0, 0, 0],    # 2 knows 0
              [1, 0, 0, 0, 0],    # 3 knows 0
              [1, 0, 0, 0, 0], ); # 4 knows 0
    is( celebrity(\@party), 0, "Example 3");

    @party = ( [0, 1, 0, 1, 0, 1],    # 0 knows 1, 3, 5
               [1, 0, 1, 1, 0, 0],    # 1 knows 0, 2, 3
               [0, 0, 0, 1, 1, 0],    # 2 knows 3, 4
               [0, 0, 0, 0, 0, 0],    # 3 knows NOBODY
               [0, 1, 0, 1, 0, 0],    # 4 knows 1, 3
               [1, 0, 1, 1, 0, 0], ); # 5 knows 0, 2, 3
    is( celebrity(\@party), 3, "Example 4");

    @party = ( [0, 1, 1, 0],   # 0 knows 1 and 2
              [1, 0, 1, 0],    # 1 knows 0 and 2
              [0, 0, 0, 0],    # 2 knows NOBODY
              [0, 0, 0, 0], ); # 3 knows NOBODY
    is( celebrity(\@party), -1, "Example 5");

    @party = ( [0, 0, 1, 1],   # 0 knows 2 and 3
              [1, 0, 0, 0],    # 1 knows 0
              [1, 1, 0, 1],    # 2 knows 0, 1 and 3
              [1, 1, 0, 0], ); # 3 knows 0 and 1
    is( celebrity(\@party), -1, "Example 6");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}
