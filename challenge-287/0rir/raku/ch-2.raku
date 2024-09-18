#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
287-2: Valid Number         Submitted by: Mohammad Sajid Anwar
You are given a string, $str.
Write a script to find if it is a valid number.

Conditions for a valid number:
- An integer number followed by an optional exponent.
- A decimal number followed by an optional exponent.
- An integer number is defined with an optional sign '-' or '+' followed by digits.
Decimal Number:

A decimal number is defined with an optional sign '-' or '+' followed by one of the following definitions:
- Digits followed by a dot '.'.
- Digits followed by a dot '.' followed by digits.
- A dot '.' followed by digits.
Exponent:

An exponent is defined with an exponent notation 'e' or 'E' followed by an integer number.
Example 1
Input: $str = "1"
Output: true
Example 2
Input: $str = "a"
Output: false
Example 3
Input: $str = "."
Output: false
Example 4
Input: $str = "1.2e4.2"
Output: false
Example 5
Input: $str = "-1."
Output: true
Example 6
Input: $str = "+1E-8"
Output: true
Example 7
Input: $str = ".44"
Output: true
=end comment



my @Test =
    "0",        True,
    "1",        True,
    "11",       True,
    "-1",       True,
    "-11",      True,
    "+1",       True,
    "+11",      True,
    "+1E8",     True,
    "-1E-8",    True,
    "+123e-8",  True,
    "-12e8",    True,
    ".1",       True,
    "+.1",      True,
    "-.1",      True,
    "-0.1",     True,
    '0.00',     True,
    '+0.001',   True,
    '-0.001',   True,
    '0.001e2',  True,
    '-0.001E2', True,
    '+0.001e2', True,
    '+0.1',     True,
    "1.2e4",    True,
    ".44",      True,
    "0.44",     True,
    "1a",       False,
    "a",        False,
    "a1",       False,
    ".",        False,
    "1.2e4.2",  False,
    "01.2e4",   False,
    "1.2e",     False,
    "1..2",     False,
    "1.2e4e2",  False,
;
plan @Test ÷ 2;

=begin comment 
            Disallowing padding zeros.
=end comment

grammar Number {
    token   TOP     { ^
                         | <zero>
                         | [  [ <decimal> | <integer> ]  <exponent>?  ]
                      $
                    }

    token decimal   {  | [ <integer>            '.'  <fraction>?  ]
                       | [ [ <sign>? <zero>? ]  '.'  <fraction>   ]
                    }

    token integer   { [ <sign>? <[1..9]> \d* ]  }   # [ <sign>? \d+ ] zed pad
    token zero      { '0' }                         # delete for zed pad
    token fraction  { \d+ }
    token exponent  { [ e | E ] <integer>  } 
    token sign      { [ '+' | '-' ] }
}

sub task( $a) { ? Number.parse( $a); }

for @Test -> $in, $exp {
    is task($in), $exp, "$exp <- $in";
}

done-testing;
my $str = "+1234.567e890";
say "\nInput: \$str = \"$str\"\nOutput: ", task $str;


