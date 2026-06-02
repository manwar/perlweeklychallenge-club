#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given two coordinates of a square on 8x8 chessboard.

Write a script to find the given two coordinates have the same colour.

8 W B W B W B W B
7 B W B W B W B W
6 W B W B W B W B
5 B W B W B W B W
4 W B W B W B W B
3 B W B W B W B W
2 W B W B W B W B
1 B W B W B W B W
  a b c d e f g h

Example 1

Input: $c1 = "a7", $c2 = "f4"
Output: true

Example 2

Input: $c1 = "c1", $c2 = "e8"
Output: false

Example 3

Input: $c1 = "b5", $c2 = "h2"
Output: false

Example 4

Input: $c1 = "f3", $c2 = "h1"
Output: true

Example 5

Input: $c1 = "a1", $c2 = "g8"
Output: false
=cut





use constant { true => 1, false => 0 };
use Test2::V0 -no_srand => 1;

is(chessboard_squares("a7", "f4"), true, 'Example 1');
is(chessboard_squares("c1", "e8"), false, 'Example 2');
is(chessboard_squares("b5", "h2"), false, 'Example 3');
is(chessboard_squares("f3", "h1"), true, 'Example 4');
is(chessboard_squares("a1", "g8"), false, 'Example 5');

done_testing();

sub chessboard_squares
{
     my ($c1, $c2) = @_;
     my %chess = make_chessboard();
     return $chess{$c1} eq $chess{$c2} || false;
}

sub make_chessboard
{
     my %board;
     my %colors = (1 => 'B', -1 => 'W');
     for my $number ( 1 .. 8 )
     {
          my $flip = $number % 2 ? 1 : -1;
          for my $letter ( 'a' .. 'h' )
          {
               my $field = $letter . $number;
               $board{$field} = $colors{$flip};
               $flip = -$flip;
          }
     }
     return %board;
}
