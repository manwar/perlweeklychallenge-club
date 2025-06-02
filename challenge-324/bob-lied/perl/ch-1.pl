#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 324 Task 1  2D Array
#=============================================================================
# You are given an array of integers and two integers $r amd $c.
# Write a script to create two dimension array having $r rows and $c
# columns using the given array.
# Example 1 Input: @ints = (1, 2, 3, 4), $r = 2, $c = 2
#           Output: ([1, 2], [3, 4])
# Example 2 Input: @ints = (1, 2, 3), $r = 1, $c = 3
#           Output: ([1, 2, 3])
# Example 3 Input: @ints = (1, 2, 3, 4), $r = 4, $c = 1
#           Output: ([1], [2], [3], [4])
#=============================================================================

use v5.40;


use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;

my $Row;
my $Col;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose,
           "row:i" => \$Row, "col:i" => \$Col);
my $logger;
{
    use Log::Log4perl qw(:easy);
    Log::Log4perl->easy_init({ level => ($Verbose ? $DEBUG : $INFO ),
            layout => "%d{HH:mm:ss.SSS} %p{1} %m%n" });
    $logger = Log::Log4perl->get_logger();
}
#=============================================================================

exit(!runTest()) if $DoTest;

unless ( $Row && $Col && @ARGV )
{
    $logger->error("Usage: $0 -r ROW -c COL a b c d...");
    exit(1);
}

my $Array;
try {
    $Array = makeArray($Row, $Col, @ARGV);
}
catch ( $err )
{
    say $logger->error($err);
    exit 1;
}
use Data::Dumper; $Data::Dumper::Indent = 0; $Data::Dumper::Terse = 1;
say Dumper($Array);

#=============================================================================
sub makeArray($r, $c, @ints)
{
    my @array;
    if ( $r * $c != @ints )
    {
        die "Size error $r X $c (". $r*$c .") != ". scalar(@ints);
    }
    while ( @ints )
    {
        push @array, [ splice(@ints, 0, $c) ];
    }
    return \@array;
}

sub runTest
{
    use Test2::V0;

    is( makeArray(2,2, 1,2,3,4), [[1,2],[3,4]    ], "Example 1");
    is( makeArray(1,3, 1,2,3  ), [[1,2,3]        ], "Example 2");
    is( makeArray(4,1, 1,2,3,4), [[1],[2],[3],[4]], "Example 3");

    like( dies { makeArray(7,3, 2,4,6) }, qr/Size error/, "Wrong dimensions");

    done_testing;
}
