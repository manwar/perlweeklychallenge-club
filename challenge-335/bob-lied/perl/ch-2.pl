#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 335 Task 2  Find Winner
#=============================================================================
# You are given an array of all moves by the two players. Write a script
# to find the winner of the TicTacToe game if found based on the moves
# provided in the given array.
# Example 1 Input: @moves = ([0,0],[2,0],[1,1],[2,1],[2,2])
#           Output: A
#   Game Board: [ A _ _ ]
#               [ B A B ]
#               [ _ _ A ]
# Example 2 Input: @moves = ([0,0],[1,1],[0,1],[0,2],[1,0],[2,0])
#           Output: B
#   Game Board: [ A A B ]
#               [ A B _ ]
#               [ B _ _ ]
# Example 3 Input: @moves = ([0,0],[1,1],[2,0],[1,0],[1,2],[2,1],[0,1],[0,2],[2,2])
#           Output: Draw
#   Game Board: [ A A B ]
#               [ B B A ]
#               [ A B A ]
# Example 4 Input: @moves = ([0,0],[1,1])
#           Output: Pending
#   Game Board: [ A _ _ ]
#               [ _ B _ ]
#               [ _ _ _ ]
# Example 5 Input: @moves = ([1,1],[0,0],[2,2],[0,1],[1,0],[0,2])
#           Output: B
#   Game Board: [ B B B ]
#               [ A A _ ]
#               [ _ _ A ]
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
# Solution 1: Procedural, obvious lookup of combinations
#=============================================================================

sub show($board)
{
    my $s = "\n";
    for my $row ( $board->@* )
    {
        $s .= "[ ". join(' ', $row->@*) . " ]\n";
    }
    return $s;
}

sub getRow($board)
{
    return ( map { join('', $_->@*) } $board->@* );
}

sub getCol($board)
{
    my @column;
    for my $col ( 0 .. 2 )
    {
        push @column, join('', map { $_->[$col] } $board->@*);
    }
    return @column;
}

sub getDiagonal($board)
{
    return ( join('', map { $board->[$_  ][$_] } 0, 1, 2),
             join('', map { $board->[2-$_][$_] } 2, 1, 0) );
}

exit(!runTest()) if $DoTest;
exit( runBenchmark($Benchmark) ) if $Benchmark;

my @MOVE = map { [split(',', $_)] } @ARGV;
say findWinner(@MOVE);

#=============================================================================
sub findWinner(@move)
{
    my @board;
    push @board, [ ('_') x 3 ] for 1 .. 3;
    state @player = ('A', 'B');
    my $turn = 0;

    for my $m ( @move )
    {
        $board[$m->[0]][$m->[1]] = $player[$turn];
        $turn = ($turn + 1) % 2;
    }
    $logger->debug( show(\@board) );

    my @triple = ( getRow(\@board), getCol(\@board), getDiagonal(\@board) );
    $logger->debug( "@triple" );
    use feature 'keyword_any'; no warnings 'experimental::keyword_any';
    if    ( any { $_ eq 'AAA' } @triple ) { return 'A'; }
    elsif ( any { $_ eq 'BBB' } @triple ) { return 'B'; }
    elsif ( scalar(@move) == 9 )          { return 'Draw'; }
    else                                  { return "Pending"; }
}

#=============================================================================
# Solution 2: Using a class for player positions and a bitmap
#=============================================================================
use FindBin qw/$Bin/; use lib "$FindBin::Bin";
use TTTPlayer;

sub findWinnerOO(@move)
{
    my @player = ( TTTPlayer->new(name => 'A'), TTTPlayer->new(name => 'B') );

    for my ($i, $m) (indexed @move)
    {
        # Odd moves go to player A, even go to player B
        my $p = $player[$i % 2];
        if    ( $p->move(@$m)->hasWin() ) { return $p->name(); }
    }
    if   ( scalar(@move) == 9 )   { return 'Draw'; }
    else                          { return "Pending"; }
}


sub runTest
{
    use Test2::V0;

    is( findWinner( [0,0],[2,0],[1,1],[2,1],[2,2]       ), 'A', "Example 1");
    is( findWinner( [0,0],[1,1],[0,1],[0,2],[1,0],[2,0] ), 'B', "Example 2");
    is( findWinner( [0,0],[1,1],[2,0],[1,0],[1,2],[2,1],[0,1],[0,2],[2,2]), 'Draw', "Example 3");
    is( findWinner( [0,0],[1,1] ),                         'Pending', "Example 4");
    is( findWinner( [1,1],[0,0],[2,2],[0,1],[1,0],[0,2] ), 'B',       "Example 5");

    is( findWinnerOO( [0,0],[2,0],[1,1],[2,1],[2,2]       ), 'A', "Example 1 OO");
    is( findWinnerOO( [0,0],[1,1],[0,1],[0,2],[1,0],[2,0] ), 'B', "Example 2 OO");
    is( findWinnerOO( [0,0],[1,1],[2,0],[1,0],[1,2],[2,1],[0,1],[0,2],[2,2]), 'Draw', "Example 3 OO");
    is( findWinnerOO( [0,0],[1,1] ),                         'Pending', "Example 4 OO");
    is( findWinnerOO( [1,1],[0,0],[2,2],[0,1],[1,0],[0,2] ), 'B',       "Example 5 OO");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}
