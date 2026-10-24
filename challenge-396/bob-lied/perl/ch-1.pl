#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 396 Task 1  Finishing Order
#=============================================================================
# You are given two array of integers, @order and @friends.
# The @order (size n) contains every integer from 1 to n exactly once.
# The @friends contains ID in sorted in strictly increasing order.
# Write a script to return the array containing IDs in finishing order.
# Example 1 Input: @order = (3, 1, 4, 2, 5)
#                  @friends = (1, 2, 4)
#           Output: (1, 4, 2)
#   ID 1 finished 2nd.  ID 4 finished 3rd.  ID 2 finished 4th.
# Example 2 Input: @order = (5, 4, 3, 2, 1)
#           @friends = (1, 3, 5)
#           Output: (5, 3, 1)
#   ID 5 finished 1st.  ID 3 finished 3rd.  ID 1 finished 5th.
# Example 3 Input: @order = (2, 4, 1, 3)
#           @friends = (1, 2, 3, 4)
#           Output: (2, 4, 1, 3)
#   ID 2 finished 1st.  ID 4 finished 2nd.  ID 1 finished 3rd.  ID 3 finished 4th.
# Example 4 Input: @order = (4, 1, 3, 2)
#           @friends = (3)
#           Output: (3)
# Example 5 Input: @order = (1, 3, 2, 6, 5, 4)
#           @friends = (1, 2, 3)
#           Output: (1, 3, 2)
#   ID 1 finished 1st.  ID 3 finished 2nd.  ID 2 finished 3rd.  #=============================================================================

use v5.44;


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

# Give arguments as CSV, example: $0 3,1,4,2,5 1,2,4
my @Order = split(',', shift);
my @Friends = split(',', shift);
say '(', join(", ", task(\@Order, \@Friends)->@*), ')';

#=============================================================================
sub task($order, $friends)
{
    my $i = 0;
    my %place = map { $_ => $i++ } $order->@*;

    return [ sort { $place{$a} <=> $place{$b} } $friends->@* ];
}

sub runTest
{
    use Test2::V1 -ipP;

    my @t = (
    { desc => "Example 1",
        order   => [ 3, 1, 4, 2, 5 ],
        friends => [ 1, 2, 4 ],
        expect  => [ 1, 4, 2 ],
    },
    { desc => "Example 2",
        order   => [ 5, 4, 3, 2, 1 ],
        friends => [ 1, 3, 5 ],
        expect  => [ 5, 3, 1 ],
    },
    { desc => "Example 3",
        order   => [ 2, 4, 1, 3 ],
        friends => [ 1, 2, 3, 4 ],
        expect  => [ 2, 4, 1, 3 ],
    },
    { desc => "Example 4",
        order   => [ 4, 1, 3, 2 ],
        friends => [ 3 ],
        expect  => [ 3 ],
    },
    { desc => "Example 5",
        order   => [ 1, 3, 2, 6, 5, 4 ],
        friends => [ 1, 2, 3 ],
        expect  => [ 1, 3, 2 ],
    },
    );

    my @task = ( \&task );

    for my $f ( @task )
    {
        for my $c ( @t )
        {
            is( $f->($c->{order}, $c->{friends}), $c->{expect}, $c->{desc} );
        }
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

