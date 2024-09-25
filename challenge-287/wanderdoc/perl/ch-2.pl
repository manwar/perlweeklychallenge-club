#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
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
=cut



use constant {true => 1, false => 0};
use Test2::V0;


is(validate_number('1'), true, 'Example 1');
is(validate_number('a'), false, 'Example 2');
is(validate_number('.'), false, 'Example 3');
is(validate_number('1.2e4.2'), false, 'Example 4');
is(validate_number('-1.'), true, 'Example 5');
is(validate_number('+1E-8'), true, 'Example 6');
is(validate_number('.44'), true, 'Example 7');

is(validate_number('-1.2e-3'), true, 'Example 8 (added)');
is(validate_number('+1.e-3'), true, 'Example 9 (added)');


done_testing();




sub validate_number
{
     my $str = $_[0];
     # These are just strings (q or qq):
     my $integer = q/[-+]?\d+/;
     my $exponent = qq/[eE]${integer}/;
     my $decimal = q/[-+]?(?:\d+\.|\d+\.\d+|\.\d+)/;


     # This is the only qr statement:
     my $valid_num = qr/(?:${integer}|${decimal})(?:${exponent})?/;
     return $str =~ /\A${valid_num}\z/ ? true : false; 
}