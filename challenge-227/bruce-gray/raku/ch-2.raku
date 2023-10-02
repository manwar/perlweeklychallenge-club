# I spliced together https://rosettacode.org/wiki/Roman_numerals/ and
# https://andrewshitov.com/2018/10/31/creating-a-calculator-with-perl-6-grammars/
# , added `**`, trimmed out the calc code that supported PEDMAS precedence and
# expressions of more than 2 terms, used Int::polydiv to implify because it is
# perfect for this task, then refactored everything.
use Int::polydiv;
constant @r_pairs =
    M  => 1000,    CM =>  900,    D  =>  500,    CD =>  400,
    C  =>  100,    XC =>   90,    L  =>   50,    XL =>   40,
    X  =>   10,    IX =>    9,    V  =>    5,    IV =>    4,
    I  =>    1,
;
constant @roman_letters = @r_pairs».key;
constant @roman_values  = @r_pairs».value;
constant %r             = @r_pairs;

constant %operator_sub = <   +     -     *     /     **  >
                      Z=>  &[+], &[-], &[*], &[/], &[**]  ;
constant @operators = %operator_sub.keys;

# The Romans had no symbol for zero,
# and no numerics for fractions, negatives, or 4000+ .
multi sub to_roman ( 0                        ) { 'nulla'      }
multi sub to_roman ( Rat                      ) { 'non potest' }
multi sub to_roman ( Int  $n where   -∞ ..^ 0 ) { 'non potest' }
multi sub to_roman ( UInt $n where 4000 ..^ ∞ ) { 'non potest' }
multi sub to_roman ( UInt $n --> Str          ) {
    return [~] flat @roman_letters Zxx $n.polydiv(@roman_values);
}

grammar Calc {
    rule  TOP        { ^ <expression> $ }
    rule  expression { <term> ** 2 %% <op> }
    token op         { @operators }
    token term       { (@roman_letters)+ }
}
class CalcActions {
    method TOP        ($/) { $/.make: $<expression>.ast.narrow }
    method expression ($/) { $/.make: $<op>[0].ast.( |$<term>.map(*.ast) ) }
    method op         ($/) { $/.make: %operator_sub{ ~$/ }  }
    method term       ($/) { $/.make: %r{ $/[0] }.sum }
}

sub task2 ( Str $to_calculate --> Str ) {
    my $calc = Calc.parse( $to_calculate, :actions(CalcActions) );

    return $calc.ast.&to_roman;
}


my @tests =
    ( 'IV + V'     , 'IX'         ),
    ( 'M - I'      , 'CMXCIX'     ),
    ( 'X / II'     , 'V'          ),
    ( 'XI * VI'    , 'LXVI'       ),
    ( 'VII ** III' , 'CCCXLIII'   ),
    ( 'V - V'      , 'nulla'      ),
    ( 'V / II'     , 'non potest' ),
    ( 'MMM + M'    , 'non potest' ),
    ( 'V - X'      , 'non potest' ),
;
use Test;
plan +@tests;
for @tests -> ( $in, $expected ) {
    is task2($in), $expected;
}
