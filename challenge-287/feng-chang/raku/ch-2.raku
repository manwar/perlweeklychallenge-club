#!/bin/env raku

unit sub MAIN(Str:D $num);

grammar Number {
    rule  TOP      { <decimal> || <integer> }
    token sign     { '-' || '+' }
    token exponent { <[eE]> <sign>? <digit>+ }
    token integer  { <sign>? <digit>+ <exponent>? }
    rule  decimal  { <sign>? <digit>+ '.' <digit>* || <sign>? '.' <digit>+ }
}

put so Number.parse($num);
