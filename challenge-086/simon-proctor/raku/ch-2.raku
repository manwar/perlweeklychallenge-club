#!/usr/bin/env raku

use v6;

# So.... I wrote a whole module to do this and really can't be bothered doing it again ;) 
use Game::Sudoku;
use Game::Sudoku::Solver;

my %*SUB-MAIN-OPTS = :named-anywhere;

#! Given a 81 character string of numeric values (with 0 to represent a space) solve the sudoku puzzle
sub MAIN (
    Str $code where {$_ ~~ m/^ \d ** 81 $/ }, #= String of 81 0 to 9's representing the puzzle
) {
    my $game = Game::Sudoku.new( :$code );
    say "Starting Grid";
    say $game;
    $game = solve-puzzle( $game );
    say "Solution";
    say $game;
}
