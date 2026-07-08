#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 381 Task 1  Same Row Column
#=============================================================================
# You are given a n x n matrix containing integers from 1 to n. Write a script
# to find if every row and every column contains all the integers from 1 to n.
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

# Example usage: ch-1.pl 1,2,3  2,3,1  3,1,2
my $matrix = [ map { [ split(/,/, $_) ] } @ARGV ];
say task($matrix) ? "true" : "false";

#=============================================================================
# Using bit operations assumes we're dealing with small integers.
# Could use vec for larger range
sub bitSetOf($range, $list)
{
    my $have = 0;
    for ( $list->@* )
    {
        $have |= (1 << $_) if ( 1 <= $_ <= $range )
    }
    return $have;
}

sub task($matrix)
{
    my $range = ( my $size = $matrix->$#*) + 1;

    my $all = ( 2**$range - 1 ) << 1; # Bitmask for range bits, exclude 0

    for my $i ( 0 .. $size )
    {
        return false if bitSetOf($range, $matrix->[$i]) != $all;

        my $column = [ map { $matrix->[$_][$i] } 0 .. $size ];

        return false if bitSetOf($range, $column) != $all;
    }

    return true;

}

sub runTest
{
    use Test2::V1 -ipP;

    my @case = (
    {
        matrix => [ [1,2,3,4],[2,3,4,1],[3,4,1,2],[4,1,2,3] ],
        expect => true,
        desc => "Example 1",
    }, {
        matrix => [ [1] ],
        expect => true,
        desc => "Example 2",
    }, {
        matrix => [ [1,2,5],[5,1,2],[2,5,1] ],
        expect => false,
        desc => "Example 3",
    }, {
        matrix => [ [1,2,3],[1,2,3],[1,2,3] ],
        expect => false,
        desc => "Example 4",
    }, {
        matrix => [ [1,2,3],[3,1,2],[3,2,1]],
        expect => false,
        desc => "Example 5",
    },);

    for my $c  ( @case )
    {
        is( task($c->{matrix}), $c->{expect}, $c->{desc});
    }

    done_testing;
}
