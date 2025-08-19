#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an array of all moves by the two players.

Write a script to find the winner of the TicTacToe game if found based on the moves provided in the given array.

Example 1

Input: @moves = ([0,0],[2,0],[1,1],[2,1],[2,2])
Output: A

Game Board:
[ A _ _ ]
[ B A B ]
[ _ _ A ]


Example 2

Input: @moves = ([0,0],[1,1],[0,1],[0,2],[1,0],[2,0])
Output: B

Game Board:
[ A A B ]
[ A B _ ]
[ B _ _ ]


Example 3

Input: @moves = ([0,0],[1,1],[2,0],[1,0],[1,2],[2,1],[0,1],[0,2],[2,2])
Output: Draw

Game Board:
[ A A B ]
[ B B A ]
[ A B A ]


Example 4

Input: @moves = ([0,0],[1,1])
Output: Pending

Game Board:
[ A _ _ ]
[ _ B _ ]
[ _ _ _ ]


Example 5

Input: @moves = ([1,1],[0,0],[2,2],[0,1],[1,0],[0,2])
Output: B

Game Board:
[ B B B ]
[ A A _ ]
[ _ _ A ]
=cut




use List::Util qw(reduce);
use Test2::V0 -no_srand => 1;
is(find_winner([0,0],[2,0],[1,1],[2,1],[2,2]), 'A', 'Example 1');
is(find_winner([0,0],[1,1],[0,1],[0,2],[1,0],[2,0]), 'B', 'Example 2');
is(find_winner([0,0],[1,1],[2,0],[1,0],[1,2],[2,1],[0,1],[0,2],[2,2]), 'Draw', 'Example 3');
is(find_winner([0,0],[1,1]), 'Pending', 'Example 4');
is(find_winner([1,1],[0,0],[2,2],[0,1],[1,0],[0,2]), 'B', 'Example 5');
done_testing();

sub find_winner
{
     my @moves = @_;
     my @playerA = @moves[ grep $_ % 2 == 0, 0 .. $#moves];
     my @playerB = @moves[ grep $_ % 2 == 1, 0 .. $#moves];
     if ( has_won(@playerA) ) { return 'A'; }
     if ( has_won(@playerB) ) { return 'B';}
     if ( scalar @moves == 9) { return 'Draw';}
     return 'Pending';
}


sub has_won
{
     my @moves = @_;
     my $moves_string = reduce {$a . $b} 
          sort { $a cmp $b } map {join('',@$_)} @moves;

     if ( $moves_string eq '000102' or $moves_string eq '101112' or 
          $moves_string eq '202122' or
          $moves_string eq '001020' or $moves_string eq '101121' or
          $moves_string eq '202122' or
          $moves_string eq '001122' or $moves_string eq '021120'
     )
     {
          return 1;
     }
     return 0;
}
