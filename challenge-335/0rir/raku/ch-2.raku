#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.d;
use Test;

=begin comment
335-2: Find Winner      Submitted by: Mohammad Sajid Anwar
You are given an array of all moves by the two players.

Write a script to find the winner of the TicTacToe game if found based on the moves provided in the given array.

UPDATE: Order move is in the order - A, B, A, B, A, ….

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
=end comment

constant \EARLY = 4;
constant \DONE  = 9;
constant \PENDING = 'Pending';
constant \DRAW    = 'Draw';


my @Test =
    ([0,0],[2,0],[1,1],[2,1],[2,2]),                    'A',        # -> SE
    ([0,0],[1,1],[0,1],[0,2],[1,0],[2,0]),              'B',        # -> SW
    ([0,0],[1,1],[2,0],[1,0],[1,2],[2,1],[0,1],[0,2],[2,2]), DRAW,
    ([0,0],[1,1]),                                      PENDING,    # short
    ([1,1],[0,0],[2,2],[0,1],[1,0],[0,2]),              'B',        # -> E
    ([0,0],[1,1],[0,1],[1,0],[0,2]),                    'A',        # -> E
    ([0,0],[2,1],[1,0],[1,1],[2,0]),                    'A',        # -> S
    ([1,1],[1,2],[2,2],[0,0],[2,1],[2,0],[0,1]),        'A',
;
plan +@Test ÷ 2;

constant \_ = '_';          # empty tic
my @player = <A B>;
my @board[3;3];

# Could not get binding twixt array elems to work.

# Return True if $player has 3 in a row.
sub win-q( @b, $player, $r, $c -->Bool) {
    return True if (@b[$r;0],@b[$r;1],@b[$r;2]).all eq $player; # row

    return True if (@b[0;$c],@b[1;$c],@b[2;$c]).all eq $player; # column

    return True if (@b[0;0], @b[1;1], @b[2;2]).all eq $player   # \ slant
               and ($r,$c)  ~~ ((0,0), (1,1), (2,2)).any;

    return True if (@b[0;2], @b[1;1], @b[2;0]).all eq $player   # / slant
              and ($r, $c) ~~ ((0,2), (1,1), (2,0)).any;
    False;
}

sub task( @move  -->Str) {
    my $player = True;
    my @board[3;3] = [ [_,_,_],[_,_,_],[_,_,_]];     #empty the array;

    return PENDING if @move.elems ≤ EARLY;

    my $i = 0;
    while $i <= min DONE, @move.end {
         my $p = @player[$player.=not];         # toggle player
         my $r = @move[$i;0];
         my $c = @move[$i;1];
         @board[ $r;$c] = $p;
         if win-q( @board, $p, $r, $c) {
            return $p;
        }
         ++$i;
    }
    given $i {
        when DONE { DRAW }
        default  { PENDING}
    }
}

for @Test -> @in, $exp {
    is task( @in), $exp, "{$exp // $exp.^name()} <- @in.raku()";
}
done-testing;

my @move = [0,0],[2,0],[1,1],[2,1],[2,2];

say "\nInput: @move = @move.raku()\nOutput: {task @move}";

