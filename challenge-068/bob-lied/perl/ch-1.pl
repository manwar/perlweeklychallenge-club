#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 068 Task 1 Zero Matrix
#=============================================================================
# You are given a matrix of size M x N having only 0s and 1s.
# Write a script to set the entire row and column to 0 if an element is 0.
# Example 1 Input: [1, 0, 1]    Output: [0, 0, 0]
#                  [1, 1, 1]            [1, 0, 1]
#                  [1, 1, 1]            [1, 0, 1]
#
# Example 2 Input: [1, 0, 1]    Output: [0, 0, 0]
#                  [1, 1, 1]            [1, 0, 1]
#                  [1, 0, 1]            [0, 0, 0]
#=============================================================================

use v5.40;

use List::Util qw/product/;

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
sub zeroMatrix($matrix)
{
    my $lastRow = $matrix->$#*;
    my $lastCol = $matrix->[0]->$#*;

    $logger->debug("DIM: $lastRow X $lastCol");

    my @rowIsOne;
    for ( 0 .. $lastRow )
    {
        $rowIsOne[$_] = product $matrix->[$_]->@*;
    }

    my @colIsOne;
    for my $col ( 0 .. $lastCol )
    {
        $colIsOne[$col] = product map { $_->[$col] } $matrix->@*;
    }

    my @answer;
    for my $row ( 0 .. $lastRow )
    {
        for my $col ( 0 .. $lastCol )
        {
            $answer[$row][$col] = $rowIsOne[$row] & $colIsOne[$col];
        }
    }
    return \@answer;
}

sub runTest
{
    use Test2::V0;
    my @case = ( { input  => [ [1,0,1],[1,1,1],[1,1,1] ],
                   output => [ [0,0,0],[1,0,1],[1,0,1] ],
                   label  => "Example 1"
                 },
                 { input  => [ [1,0,1],[1,1,1],[1,0,1] ],
                   output => [ [0,0,0],[1,0,1],[0,0,0] ],
                   label  => "Example 2"
                 }
             );

    foreach ( @case )
    {
        is( zeroMatrix($_->{input}), $_->{output}, $_->{label});
    }

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}
