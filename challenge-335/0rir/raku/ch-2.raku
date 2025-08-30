#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.e.PREVIEW;
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

constant \EARLY    = 4;         # too early to have a winner
constant \DONE     = 9;         # only 9 elems can be used
constant \PENDING  = 'Pending'; # meaning of !DONE and no winner
constant \DRAW     = 'Draw';    # no victor in DONE data
constant \_        = '_';       # empty tic

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
plan 3 × +@Test ÷ 2;

# Version the first ===============================================

my @player = <A B>;
my @board[3;3];

# Could not get binding twixt array elems to work.

# Return True if $player has 3 in a row, column, or slant.
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

# Version the second, requires v6.e.PREVIEW ===========================

=begin comment
This is PWC 335 Task 2 as I initially planned to write it with a larger
array with all elems bound to the tic-tac-toe board array.  I wanted to
play with binding array positions.

This is not as clean as I had hoped.

My idea of mapping of the @b (board) to the @r (review) missed the literal
corner cases, which added four more diagonals of three.

Also my use of side effects and embedded subs implicitly accessing outer
vars seems odd.
=end comment

sub task-bind-ary( @move -->Str) {

    return PENDING if @move ≤ EARLY;

    # set up
    my @b[3;3];
    my @g[5;5];

    for 0..2 -> \i { for 0..2 -> \j { @b[i;j] =  _ ; }}

    # Bind elems of @g, the ground, to the @b, the board.

    #  @b idx       @g indices
    my @bind =
    [0,0],       [1,1, 1,4, 4,1, 4,4],
    [0,1],       [1,2, 4,2,],
    [0,2],       [1,3, 1,0, 4,0, 4,3],
    [1,0],       [2,1, 2,4,],
    [1,1],       [2,2,],
    [1,2],       [2,3, 2,0,],
    [2,0],       [3,1, 0,1, 0,4, 3,4],
    [2,1],       [3,2, 0,2,],
    [2,2],       [3,3, 0,0, 0,3, 3,0];

    for @bind -> @sq, @alias {
        my (\ro, \co) = @sq;
        for @alias -> \r, \c {
           @g[r;c] := @b[ro;co];
        }
    }

    my $i = 0;
                                # The current player
                                sub player( -->Str) { $i %% 2 ?? 'A' !! 'B' }

    ### Enter early moves
    while $i < EARLY {
        my (\r, \c) = enter-move;
        ++$i;
    }
                            # Return indices for checking against @g
                            sub enter-move(-->List) {
                                my ($r,$c) = @move[$i];
                                @b[$r;$c] = player;
                                return ( ++$r, ++$c);
                            }

    ### Enter and check moves
    while $i <  min DONE, @move {
        my (\r, \c) = enter-move;
        if win-q( r, c) {
            return player;
        }
        ++$i;
    }                       # Did current tic or big X win?
                    sub win-q( \r, \c -->Bool) {
                        return  ? any( N(r,c),E(r,c), Ne, Nw);
                    }
                    sub E( \r,\c) { @g[r;c] eq @g[r  ;c-1] eq @g[r  ;c+1]} # |
                    sub N( \r,\c) { @g[r;c] eq @g[r-1;c  ] eq @g[r+1;c  ]} # _
                    sub Nw()      { @g[2;2] eq @g[1  ;1  ] eq @g[3  ;3  ]} # \
                    sub Ne()      { @g[2;2] eq @g[1  ;3  ] eq @g[3  ;1  ]} # /

    return DRAW if $i == DONE;
    return  PENDING;
}

# Version the third ===================================================

=begin comment
This is another approach to PWC 335 Task 2.

Return pending if arg list is too short.
View the tic-tac-toe grid as locations 'a'... 'i'.
Convert the matrix indices to locations.
Iter over input list (while toggling A and B) inserting loca to a player's set.
Compare A's set, then B's, to list of winning sets.
If no winner, check move counter to choose pending or draw.
=end comment

my @win = do for <a b c>, <d e f>, <g h i>, <a d g>,
                 <b e h>, <c f i>, <a e i>, <c e g> -> $s {
                    $s.Set;
                };

sub coords2id( @a -->Str) { <a b c d e f g h i>[ @a[0] × 3 + @a[1]]; }

multi task-set( @coord where * ≤   EARLY -->Str) { PENDING }

multi task-set( @coord where * < 10       -->Str) {

    my SetHash $a;
    my SetHash $b;
    my @tic = $a, $b;

    my $player = 1;         # set Player B

    my $i = 0;
    for @coord -> @c {
        last if $i == DONE;
        $player = (!$player);
        @tic[$player]{coords2id( @c)} = True;   # take location
        ++$i;
    }

    return 'A' if @tic[0] ⊇ any @win;
    return 'B' if @tic[1] ⊇ any @win;

    return PENDING if $i < DONE;
    return DRAW;
}

# Testing ===========================================================

for @Test -> @in, $exp {
    is task(           @in), $exp, "{$exp // $exp.^name()} <- @in.raku()";
    is task-bind-ary(  @in), $exp, "{$exp // $exp.^name()} <- @in.raku()";
    is task-set(       @in), $exp, "{$exp // $exp.^name()} <- @in.raku()";
}
done-testing;

my @move = [0,0],[2,0],[1,1],[2,1],[2,2];

say "\nInput: @move = @move.raku()\nOutput: {task @move}";

