#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 354 Task 2 Shift Grid
#=============================================================================
# You are given m x n matrix and an integer, $k > 0. Write a script to
# shift the given matrix $k times. Each shift follow the rules:
# Rule 1:
#   Element at grid[i][j] moves to grid[i][j + 1]
#   This means every element moves one step to the right within its row.
# Rule 2:
#   Element at grid[i][n - 1] moves to grid[i + 1][0]
#   This handles the last column: elements in the last column of row i
#   wrap to the first column of the next row (i+1).
# Rule 3:
#   Element at grid[m - 1][n - 1] moves to grid[0][0]
#   This is the bottom-right corner: it wraps to the top-left corner.
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
sub shiftGrid($matrix, $k)
{
    # Flatten the matrix into a single row.
    my @v = map { $_->@* } $matrix->@*;

    # Rotate by k, but modulo size of the array
    $k = $k % @v;

    # Rotate the right end to left
    unshift @v, splice(@v, -$k);

    # Turn the vector back into a matrix of the right dimensions.
    my $col = scalar($matrix->[0]->@*);

    my @result;
    while ( @v )
    {
        push @result, [ splice(@v, 0, $col) ]
    }
    return \@result;
}

sub runTest
{
    use Test2::V0;

    my @case = (
        {       id => "Example 1",
            matrix => [ [1,2,3],[4,5,6],[7,8,9] ],
                 k => 1,
            expect => [ [9,1,2],[3,4,5],[6,7,8] ],
        },
        {       id => "Example 2",
            matrix => [ [10,20],[30,40] ],
                 k => 1,
            expect => [ [40,10],[20,30] ],
        },
        {       id => "Example 3",
            matrix => [ [1,2],[3,4],[5,6] ],
                 k => 1,
            expect => [ [6,1],[2,3],[4,5] ],
        },
        {       id => "Example 4",
            matrix => [ [1,2,3],[4,5,6] ],
                 k => 5,
            expect => [ [2,3,4],[5,6,1] ],
        },
        {       id => "Example 5",
            matrix => [ [1,2,3,4] ],
                 k => 1,
            expect => [ [4,1,2,3] ],
        },
        {       id => "Identity",
            matrix => [ [1,2,3,4] ],
                 k => 4,
            expect => [ [1,2,3,4] ],
        },
    );

    for ( @case )
    {
        is( shiftGrid($_->{matrix}, $_->{k}), $_->{expect}, $_->{id});
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
