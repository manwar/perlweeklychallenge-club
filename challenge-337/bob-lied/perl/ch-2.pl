#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 337 Task 2  Odd Matrix
#=============================================================================
# You are given row and col, also a list of positions in the matrix.
# Write a script to perform action on each location (0-indexed) as provided
# in the list and find out the total odd valued cells.
# For each location (r, c), do both of the following:
#   a) Increment by 1 all the cells on row r.
#   b) Increment by 1 all the cells on column c.
#
# Example 1 Input: $row = 2, $col = 3, @locations = ([0,1],[1,1])
#           Output: 6
#                                   Before     After
#   Apply [0,1]: Increment row 0:
#                                   [ 0 0 0 ]  [ 1 1 1 ]
#                                   [ 0 0 0 ]  [ 0 0 0 ]
#                 Increment col 1:
#                                   [ 1 1 1 ]  [ 1 2 1 ]
#                                   [ 0 0 0 ]  [ 0 1 0 ]
#   Apply [1,1]: Increment row 1 and col 1
#                                   [ 1 2 1 ]  [ 1 3 1 ]
#                                   [ 1 2 1 ]  [ 1 3 1 ]
#
# Example 2 Input: $row = 2, $col = 2, @locations = ([1,1],[0,0])
#           Output: 0
#                                   Before     After
#   Apply [1,1]: Increment row 1:
#                                   [ 0 0 ]   [ 0 0 ]
#                                   [ 0 0 ]   [ 1 1 ]
#               Increment col 1:
#                                   [ 0 0 ]   [ 0 1 ]
#                                   [ 1 1 ]   [ 1 2 ]
#   Apply [0,0]: Increment row 0 and col 0:
#                                   [ 1 2 ]   [ 2 2 ]
#                                   [ 1 2 ]   [ 2 2 ]
#
# Example 3 Input: $row = 3, $col = 3, @locations = ([0,0],[1,2],[2,1])
#           Output: 0
#                                   Before     After
#   Apply [0,0]: Increment row 0 and col 0:
#                                   [ 1 1 1 ]  [ 2 1 1 ]
#                                   [ 0 0 0 ]  [ 1 0 0 ]
#                                   [ 0 0 0 ]  [ 1 0 0 ]
#   Apply [1,2]: Increment row 1 and col 2:
#                                   [ 2 1 1 ]  [ 2 1 2 ]
#                                   [ 2 1 1 ]  [ 2 1 2 ]
#                                   [ 1 0 0 ]  [ 1 0 1 ]
#   Apply [2,1]: Increment row 2 and col 1:
#                                   [ 2 1 2 ]  [ 2 2 2 ]
#                                   [ 2 1 2 ]  [ 2 2 2 ]
#                                   [ 2 1 2 ]  [ 2 2 2 ]
#
# Example 4 Input: $row = 1, $col = 5, @locations = ([0,2],[0,4])
#           Output: 2
#                                   Before         After
#   Apply [0,2]: Increment row 0 and  col 2:
#                                   [ 1 1 1 1 1 ]  [ 1 1 2 1 1 ]
#   Apply [0,4]: Increment row 0 and col 4:
#                                   [ 2 2 3 2 2 ]  [ 2 2 3 2 3 ]
#
# Example 5 Input: $row = 4, $col = 2, @locations = ([1,0],[3,1],[2,0],[0,1])
#           Output: 8
#                                   Before     After
#   Apply [1,0]: Increment row 1 and col 0:
#                                   [ 0 0 ]    [ 1 0 ]
#                                   [ 1 1 ]    [ 2 1 ]
#                                   [ 0 0 ]    [ 1 0 ]
#                                   [ 0 0 ]    [ 1 0 ]
#   Apply [3,1]: Increment row 3 and col 1:
#                                   [ 1 0 ]    [ 1 1 ]
#                                   [ 2 1 ]    [ 2 2 ]
#                                   [ 1 0 ]    [ 1 1 ]
#                                   [ 2 1 ]    [ 2 2 ]
#   Apply [2,0]: Increment row 2 and col 0:
#                                   [ 1 1 ]    [ 2 1 ]
#                                   [ 2 2 ]    [ 3 2 ]
#                                   [ 2 2 ]    [ 3 2 ]
#                                   [ 2 2 ]    [ 3 2 ]
#   Apply [0,1]: Increment row 0 and col 1:
#                                   [ 3 2 ]    [ 3 3 ]
#                                   [ 3 2 ]    [ 3 3 ]
#                                   [ 3 2 ]    [ 3 3 ]
#                                   [ 3 2 ]    [ 3 3 ]
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

my $ROW = shift;
my $COL = shift;
my @LOC = map { [ split ',' ] } @ARGV;
try { say oddMatrix($ROW, $COL, @LOC); }
catch ( $e ) { say "Error: $e", "\n\t", "Usage: row col  r,c r,c" }

#=============================================================================
# Logging/debugging aid
#=============================================================================
sub showMatrix($m)
{
    return join("\n",  map { '[ ' . join(" ", $_->@*) . ' ]' } $m->@*);
}

sub oddMatrix($row, $col, @location)
{
    use List::Util qw/sum0/;
    my @matrix;
    push @matrix, [ (0) x $col ] for 1 .. $row;
    $row--; $col--; # Switch to 0-based indexing

    for (@location)
    {
        my ($r, $c) = $_->@*;
        die "Location ($r,$c) outside of ($row,$col)" if ( $r > $row || $c > $col );
        $matrix[$r][$_]++ for 0 .. $col;
        $matrix[$_][$c]++ for 0 .. $row;
        $logger->debug("After [$_->@*]:\n", showMatrix(\@matrix) ) if $Verbose;
    }

    my $oddCount = sum0 map { scalar grep { $_ % 2 } $_->@* } @matrix;
    return $oddCount;
}

sub runTest
{
    use Test2::V0;
    use Test::Exception;

    is( oddMatrix(2,3, [0,1],[1,1]             ), 6, "Example 1");
    is( oddMatrix(2,2, [1,1],[0,0]             ), 0, "Example 2");
    is( oddMatrix(3,3, [0,0],[1,2],[2,1]       ), 0, "Example 3");
    is( oddMatrix(1,5, [0,2],[0,4]             ), 2, "Example 4");
    is( oddMatrix(4,2, [1,0],[3,1],[2,0],[0,1] ), 8, "Example 5");

    is( oddMatrix(1,1, [0,0]                   ), 0, "1x1");
    like( dies { oddMatrix(2,2, [1,1],[2,2]), }, qr/Location/,  "Location out of range dies");

    done_testing;
}
