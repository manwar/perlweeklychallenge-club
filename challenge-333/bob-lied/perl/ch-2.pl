#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 333 Task 2  Duplicate Zeroes
#=============================================================================
# You are given an array of integers.  Write a script to duplicate each
# occurrence of zero, shifting the remaining elements to the right.
# The elements beyond the length of the original array are not written.
# Example 1 Input: @ints = (1, 0, 2, 3, 0, 4, 5, 0)
#           Output:        (1, 0, 0, 2, 3, 0, 0, 4)
#   Each zero is duplicated.
#   Elements beyond the original length (like 5 and last 0) are discarded.
# Example 2 Input: @ints = (1, 2, 3)
#          Output:         (1, 2, 3)
#   No zeros exist, so the array remains unchanged.
# Example 3 Input: @ints = (1, 2, 3, 0)
#           Output:        (1, 2, 3, 0)
# Example 4 Input: @ints = (0, 0, 1, 2)
#           Output:        (0, 0, 0, 0)
# Example 5 Input: @ints = (1, 2, 0, 3, 4)
#           Output:        (1, 2, 0, 0, 3)
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

say '(', join(", ", dupSplice(@ARGV)->@*), ')';
# say '(', join(", ", dupCut(@ARGV)->@*), ')';
#say '(', join(", ", duplicateZero(@ARGV)->@*), ')';

#=============================================================================
sub duplicateZero(@int)
{
    my @out;
    my $length = @int;
    while ( defined(my $n = shift @int) && @out < $length)
    {
        push @out, $n;
        push @out, 0 if $n == 0 && @out < $length;
    }
    return \@out;
}

sub dupCut(@int)
{
    my @out = map { $_ == 0 ? (0,0) : ($_) } @int;
    splice(@out, scalar(@int) ); 
    return \@out;
}

sub dupSplice(@int)
{
    my $length = @int;
    for ( reverse 0 .. $#int )
    {
        splice(@int, $_, 1,  0,0) if $int[$_] == 0;
    }
    splice(@int, $length);
    return \@int;
}

sub runTest
{
    use Test2::V0;

    is( duplicateZero( 1,0,2,3,0,4,5,0), [1,0,0,2,3,0,0,4], "Example 1");
    is( duplicateZero( 1,2,3          ), [1,2,3          ], "Example 2");
    is( duplicateZero( 1,2,3,0        ), [1,2,3,0        ], "Example 3");
    is( duplicateZero( 0,0,1,2        ), [0,0,0,0        ], "Example 4");
    is( duplicateZero( 1,2,0,3,4      ), [1,2,0,0,3      ], "Example 5");

    is( dupCut( 1,0,2,3,0,4,5,0), [1,0,0,2,3,0,0,4], "Example 1 cut");
    is( dupCut( 1,2,3          ), [1,2,3          ], "Example 2 cut");
    is( dupCut( 1,2,3,0        ), [1,2,3,0        ], "Example 3 cut");
    is( dupCut( 0,0,1,2        ), [0,0,0,0        ], "Example 4 cut");
    is( dupCut( 1,2,0,3,4      ), [1,2,0,0,3      ], "Example 5 cut");

    is( dupSplice( 1,0,2,3,0,4,5,0), [1,0,0,2,3,0,0,4], "Example 1 splice");
    is( dupSplice( 1,2,3          ), [1,2,3          ], "Example 2 splice");
    is( dupSplice( 1,2,3,0        ), [1,2,3,0        ], "Example 3 splice");
    is( dupSplice( 0,0,1,2        ), [0,0,0,0        ], "Example 4 splice");
    is( dupSplice( 1,2,0,3,4      ), [1,2,0,0,3      ], "Example 5 splice");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    my @int = map { int(rand(20)) + 1 } 1 .. 100;
    $int[$_] = 0 for map { int(rand(100)) } 1..10;
    # my @int = (0) x 100;

    cmpthese($repeat, {
            copy   => sub { duplicateZero(@int) },
            cut    => sub { dupCut(@int) },
            splice => sub { dupSplice(@int) },
        });
}
