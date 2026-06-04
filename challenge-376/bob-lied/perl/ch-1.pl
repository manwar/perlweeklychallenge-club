#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 376 Task 1  Chessboard Squares
#=============================================================================
# You are given two coordinates of a square on 8x8 chessboard.
# Write a script to find the given two coordinates have the same colour.
#   8 W B W B W B W B
#   7 B W B W B W B W
#   6 W B W B W B W B
#   5 B W B W B W B W
#   4 W B W B W B W B
#   3 B W B W B W B W
#   2 W B W B W B W B
#   1 B W B W B W B W
#     a b c d e f g h
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

use feature 'class'; no warnings "experimental::class";

#   8 W B W B W B W B       7 | w
#   7 B W B W B W B W       6 | b w
#   6 W B W B W B W B       5 | w b w
#   5 B W B W B W B W       4 | b w b w ...
#   4 W B W B W B W B       3 |       .
#   3 B W B W B W B W       2 |       .
#   2 W B W B W B W B       1 |       .
#   1 B W B W B W B W       0 |________________
#     a b c d e f g h           0 1 2 3 4 5 6 7

class ChessBoard
{
    use Carp;
    use enum qw(BLACK WHITE);

    method colorAt($position) {
        my ($rank, $file) = posToGrid($position);
        return (( $rank + $file ) % 2) ? WHITE : BLACK;
    }

    method place($piece, $position) { ... }
    method remove($position) { ... }
    method pieceAt($position) { ... }


    sub posToGrid($position) {
        my ($rank, $file) = ( ord(lc(substr($position, 0, 1))) - ord('a'),
                                     substr($position, 1, 1) - 1 );

        croak "Bad position '$position'"
            if $rank < 0 || $rank > 7 || $file < 0 || $file > 7;

        return ($rank, $file);
    }
}
#=============================================================================

exit(!runTest()) if $DoTest;

say task(@ARGV);

#=============================================================================
sub task($c1, $c2)
{
    my $board = ChessBoard->new();

    return $board->colorAt($c1) == $board->colorAt($c2);
}

sub runTest
{
    use Test2::V0;

    is( task("a7", "f4"),  true, "Example 1");
    is( task("c1", "e8"), false, "Example 2");
    is( task("b5", "h2"), false, "Example 3");
    is( task("f3", "h1"),  true, "Example 4");
    is( task("a1", "g8"), false, "Example 5");

    done_testing;
}
