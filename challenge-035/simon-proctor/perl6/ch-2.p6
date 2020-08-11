#!/usr/bin/perl6

# See my earlier comment on Bit twiddling.
# I should probably make it work with streams...

use v6;

constant %REVERSE-MORSE-MAP = (
    '10111' => 'A',         '111010101' => 'B',     '11101011101' => 'C',    '1110101' => 'D',
    '1' => 'E',             '101011101' => 'F',     '111011101' => 'G',      '1010101' => 'H',
    '101' => 'I',           '1011101110111' => 'J', '111010111' => 'K',      '101110101' => 'L',
    '1110111' => 'M',       '11101' => 'N',         '11101110111' => 'O',    '10111011101' => 'P',
    '1110111010111' => 'Q', '1011101' => 'R',       '10101' => 'S',          '111' => 'T',
    '1010111' => 'U',       '101010111' => 'V',     '101110111' => 'W',      '11101010111' => 'X',
    '1110101110111' => 'Y', '11101110101' => 'Z',   '0000000'   => ' ',      '000' => '',
);

#| Help
multi sub MAIN( Bool :h(:$help) where so * ) {
    say $*USAGE;
}

#| Converts an encoded 
#| Reads from STDIN write to STDOUT
multi sub MAIN() {
    say $*IN
    .slurp(:bin)
    .decode("ascii")
    .comb()
    .map( *.ord )
    .map( *.base(2) )
    .map( *.fmt( "%07s" ) )
    .join("")
    .subst( /^0+/, "" )
    .split("0000000")
    .map( *.split("000").map( { %REVERSE-MORSE-MAP{$_} } ).join("") ).join(" ")
    ;
}
