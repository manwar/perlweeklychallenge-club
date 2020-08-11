#!/usr/bin/env perl6

# I suck at bit twiddling.
# This explains why I did what I did.

use v6;

constant %MORSE-MAP = (
    A => '10111',         B => '111010101',     C => '11101011101',    D => '1110101',
    E => '1',             F => '101011101',     G => '111011101',      H => '1010101',
    I => '101',           J => '1011101110111', K => '111010111',      L => '101110101',
    M => '1110111',       N => '11101',         O => '11101110111',    P => '10111011101',
    Q => '1110111010111', R => '1011101',       S => '10101',          T => '111',
    U => '1010111',       V => '101010111',     W => '101110111',      X => '11101010111',
    Y => '1110101110111', Z => '11101110101',   ' ' => '0'
);

#| Help
multi sub MAIN( Bool :h(:$help) where so * ) {
    say $*USAGE;
}

#| Converts an sentence (a-z only) into morse and stores it as binary.
#| Reads from STDIN write to STDOUT ASCII encoded.
multi sub MAIN() {
    my $input = $*IN.slurp.chomp.uc;
    die "A-Z AND SPACES ONLY STOP PLEASE TRY AGAIN STOP" unless $input ~~ m!^ <[A..Z \  \n \t]>+ $!; 

    my $bin-morse = $input.comb().map( { $_.subst( /\n|\t/, " " ) } ).map( { %MORSE-MAP{$_} } ).join('000');
    $bin-morse = "{'0' x 7 - ( $bin-morse.codes % 7 ) }{$bin-morse}";
    my @stream = $bin-morse.comb(/. ** {7}/).map( *.parse-base(2) );
    print Blob.new(@stream).decode("ascii");
}
