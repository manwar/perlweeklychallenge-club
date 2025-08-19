#!/usr/bin/env raku

subset Move of Int where 0 <= * <= 2;

class OXO {
    has @.board = [[' ',' ',' '],[' ',' ',' '],[' ',' ',' ']];
    has Str $!current = 'A';
    
    multi method move(@move where @move.elems==2 && all(@move) ~~ Move) {
        self.move(|@move);
    }
    multi method move(Move $x,Move $y where @!board[$x][$y] ~~ ' ') {
        @!board[$x][$y] = $!current;
        $!current = $!current ~~ 'A' ?? 'B' !! 'A';
        return self;
    }
    multi method move($x,$y) { fail "{$x} {$y} is already filled"}
    method moves(@moves) {
        self.move($_) for @moves;
    }

    
    method Str { @!board.Str }
    method gist { @!board.map(*.join("|")).join("\n-+-+-\n") }

    method winner() {
        my $victory = any(
            all(@!board[0][0],@!board[0][1],@!board[0][2]),
            all(@!board[1][0],@!board[1][1],@!board[1][2]),
            all(@!board[2][0],@!board[2][1],@!board[2][2]),
            all(@!board[0][0],@!board[1][0],@!board[2][0]),
            all(@!board[0][1],@!board[1][1],@!board[2][1]),
            all(@!board[0][2],@!board[1][2],@!board[2][2]),
            all(@!board[0][0],@!board[1][1],@!board[2][2]),
            all(@!board[2][0],@!board[1][1],@!board[0][2])
        );
        return 'A' if $victory ~~ 'A';
        return 'B' if $victory ~~ 'B';
        return 'Draw' if none(@!board.map(*.flat).flat) ~~ ' ';
        return 'Pending';
    }
}


sub MAIN(:t(:$test)) is hidden-from-USAGE {
    use Test;
    my @tests = (
        [[[0,0],[2,0],[1,1],[2,1],[2,2]],'A'],
        [([0,0],[1,1],[0,1],[0,2],[1,0],[2,0]),'B'],
        [([0,0],[1,1],[2,0],[1,0],[1,2],[2,1],[0,1],[0,2],[2,2]),'Draw'],
        [([0,0],[1,1]),'Pending']
    );
    for @tests -> $test {
        my $moves = $test[0];
        my $expected = $test[1];
        my $board = OXO.new;
        $board.moves($moves);
        is $board.winner, $expected, "\n{$board.gist} victory for {$expected}";
    }
    done-testing
}
