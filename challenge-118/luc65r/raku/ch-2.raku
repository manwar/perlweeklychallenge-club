#!/usr/bin/env raku

#`{
Brute force implementation.
Provides the shortest path, but takes about 15 to 20 minutes.
}

subset Coordinate of UInt where 1 ≤ * ≤ 8;

class Square {
    has Coordinate $.y is required;
    has Coordinate $.x is required;

    method new(Coordinate:D $y, Coordinate:D $x --> Square:D) {
        self.bless: :$y, :$x
    }
    method Str(Square:D: --> Str:D) {
        self.gist
    }
    method gist(Square:D: --> Str:D) {
        ('a' .. 'h')[$!x - 1] ~ $!y
    }
    method WHICH(Square:D: --> ValueObjAt) {
        ValueObjAt.new: "Square|$!y|$!x"
    }

    method knight-moves(Square:D: --> Seq) {
        gather {
            for -1, 1 -> $i {
                for -2, 2 -> $j {
                    try take Square.new: $!y + $i, $!x + $j;
                    try take Square.new: $!y + $j, $!x + $i;
                }
            }
        }
    }

    method search(
        Square:D:
        Set[Square:D] $treasures,
        UInt $depth,
        Square:_ $last = Square,
        --> Str:_
    ) {
        return if $depth == 0;

        for self.knight-moves -> $square {
            next if $last && $last === $square;

            my Set[Square:D] $remaining = $treasures ∖ $square;
            return ~$square if $remaining == ∅;
            return "$square $_" with $square.search: $remaining, $depth - 1, self;
        }
    }
}

grammar Chessboard {
    regex TOP { <.letters>? <line> ** 8 <.letters>? }

    rule letters { \s* <.alpha> ** 8 }
    rule line { \s* \d? <square> ** 8 \d? }

    proto token square { * }
    token square:sym('*') { <sym> }
    token square:sym<x> { <sym> }
    token square:sym<N> { <sym> }
}

class Board {
    has UInt $!y = 8;
    has UInt $!x = 1;
    has Square $!start;
    has Square @!treasures;

    method TOP($/) { make self }
    method line($/) { $!y--; $!x = 1 }
    method square:sym('*')($/) { $!x++ }
    method square:sym<x>($/) { @!treasures.push: Square.new: $!y, $!x++ }
    method square:sym<N>($/) { $!start = Square.new: $!y, $!x++ }

    method search(Board:D: --> Str:D) {
        my $treasures = Set[Square:D].new: @!treasures;
        for 0..∞ -> $i {
            return $_ with Square.new(8, 1).search: $treasures, $i;
        }
    }
}

sub MAIN(Str:D $file = '-') {
    say Chessboard.parsefile($file, actions => Board.new).made.search;
}
