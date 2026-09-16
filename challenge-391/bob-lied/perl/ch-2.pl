#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge  Task 2  Arrange Box
#=============================================================================
# You are given an array of box dimensions.  Write a script to determine the
# maximum number of these boxes that can fit inside each other in a single
# stack. For a box to fit inside another, it must be smaller in both dimensions.
# Example 1 Input: @boxes = ([1, 3], [3, 5], [6, 8], [2, 4])
#           Output: 4
#   Sort by width ascending: ([1, 3], [2, 4], [3, 5], [6, 8])
#   Extract heights: [3, 4, 5, 8]
#   [1, 3] -> [2, 4] -> [3, 5] -> [6, 8]
# Example 2 Input: @boxes = ([4, 5], [4, 6], [6, 7], [2, 3], [4, 3])
#           Output: 3
#   Sort by width ascending: ([2, 3], [4, 6], [4, 5], [4, 3], [6, 7])
#   Extract heights: (3, 6, 5, 3, 7)
#   [2, 3] -> [4, 5] -> [6, 7]
# Example 3 Input: @boxes = ([5, 5], [5, 5], [5, 5])
#           Output: 1
#   Sort by width ascending: ([5, 5], [5, 5], [5, 5])
#   Extract heights: (5, 5, 5)
#   [5, 5]
# Example 4 Input: @boxes = ([2, 100], [3, 200], [4, 300], [5, 50], [5, 400])
#           Output: 4
#   Sort by width ascending: ([2, 100], [3, 200], [4, 300], [5, 400], [5, 50])
#   Extract heights: (100, 200, 300, 400, 50)
#   [2, 100] -> [3, 200] -> [4, 300] -> [5, 400]
# Example 5 Input: @boxes = ([10, 20], [15, 10], [20, 30], [12, 18], [16, 25])
#           Output: 3
#   Sort by width ascending: ([10, 20], [12, 18], [15, 10], [16, 25], [20, 30])
#   Extract heights: (20, 18, 10, 25, 30)
#   [15, 10] -> [16, 25] -> [20, 30]
#=============================================================================

use v5.44;

use Data::Dumper; $Data::Dumper::Indent = 0; $Data::Dumper::Sortkeys = true;

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

# Give arguments as pairs of w,h
say task( map { [ split /,/ ] } @ARGV );

#=============================================================================
use feature 'class'; no warnings "experimental::class";

class Box {
    field $w : param(width)  :reader;
    field $h : param(height) :reader;

    method show() { "[$w x $h]" }
    use overload '""' => sub { $_[0]->show() };

    method canHold($other)
    {
        return $other->w < $w && $other->h < $h;
    }

}

# The examples imply that the solution can be found by sorting by width
# and height, but that fails if a very wide or skinny box is in the list
# for example: [10,10][9,1][5,5][4,4][3,3] can potentially stack 4 boxes
# if we ignore [9,1], but sorting places [9,1] inside [10,10], which
# blocks any of the rest from being added.
#
# Although not implied by the task problem, there are two things that
# could be attempted to make bigger stacks, but
# 1) We are not going to try rotations.
# 2) We are not going to try placing boxes side-by-side.

sub task(@boxes)
{
    return 0 unless @boxes;

    # Turn given size pairs into Box objects.
    my @box = map { Box->new(width => $_->[0], height => $_->[1]) } @boxes;
    $logger->debug("BEGIN: @box");

    my $biggest = 1;

    # Any box can potentially be the biggest container. Set up a todo list,
    # where each item contains the stack so far, and the possible boxes that
    # could still fit inside. There's also a "depth" tag, for logging.
    my @todo = ();
    for my $b ( @box )
    {
        my $stack     = [ $b ];
        my $available = [ grep { $b->canHold($_) } @box ];
        my $depth = 0;
        push @todo, [ $stack, $available, $depth ];
    }

    while ( my $x = shift @todo )
    {
        my ($stack, $available, $d) = $x->@*;
        $logger->debug((" "x$d), "TRY stack=(@$stack), available=(@$available)");

        $biggest = @$stack if ( @$stack > $biggest );

        # We can stop working on this stack if there aren't enough boxes
        # to improve on biggest
        next if ( @$available == 0 || @$stack + @$available) <= $biggest;

        for my $nextSmallerBox ( $available->@* )
        {
            push @todo, [ [ $stack->@*, $nextSmallerBox ],
                        [ grep { $nextSmallerBox->canHold($_) } $available->@* ],
                          $d+2 ];
        }
        $logger->debug(" "x$d, "biggest=$biggest todo: ", scalar(@todo));
    }
    return $biggest;
}

sub runTest
{
    use Test2::V1 -ipP;

    is( task(                   [1, 3], [3, 5], [6, 8], [2, 4] ), 4, "Example 1");
    is( task(           [4, 5], [4, 6], [6, 7], [2, 3], [4, 3] ), 3, "Example 2");
    is( task(                           [5, 5], [5, 5], [5, 5] ), 1, "Example 3");
    is( task( [2, 100], [3, 200], [4, 300], [ 5, 50], [5, 400] ), 4, "Example 4");
    is( task( [10, 20], [15, 10], [20, 30], [12, 18], [16, 25] ), 3, "Example 5");
    is( task( [10, 10], [ 9,  1], [ 5,  5], [ 4,  4], [ 3,  3] ), 4, "Skinny box");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}
