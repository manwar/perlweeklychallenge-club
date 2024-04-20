#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
265-2: Completing Word          Submitted by: Mohammad Sajid Anwar
You are given a string, $str containing alphnumeric characters and array
of strings (alphabetic characters only), @str.

Write a script to find the shortest completing word. If none found return empty
 string.

A completing word is a word that contains all the letters in the given string, ignoring space and number. If a letter appeared more than once in the given string then it must appear the same number or more in the word.

Example 1
Input: $str = 'aBc 11c'
       @str = ('accbbb', 'abc', 'abbc')
Output: 'accbbb'

The given string contains following, ignoring case and number:
a 1 times
b 1 times
c 2 times

The only string in the given array that satisfies the condition is 'accbbb'.
Example 2
Input: $str = 'Da2 abc'
       @str = ('abcm', 'baacd', 'abaadc')
Output: 'baacd'
Example 3
Input: $str = 'JB 007'
       @str = ('jj', 'bb', 'bjb')
Output: 'bjb'
=end comment

my @Test =
    # in        choices                         exp
    'JB 007',   ['jj', 'bb', 'bjb'],            'bjb',
    'Da2 abc',  ['abcm', 'baacd', 'abaadc'],    'baacd',
    'aBc 11c',  ['accbbb', 'abc', 'abbc'],      'accbbb',
    'abb cDE',  ['abcDE', 'abcde', 'abcdde'],   '',
    'abb cDE',  ['abcDE', 'abcde', 'ABcbde'],   'ABcbde',
    'abb cDE',  ['abBCDEE', 'abcde', 'abcdbe'], 'abcdbe',
    'abb cDE',  ['abcde', 'abcdbe','abBCDEE' ], 'abcdbe',
    'ab',       ['abcde', 'ABc','abB' ],        'ABc',
;
plan @Test ÷ 3;

sub func( $str is copy, @str -->Str) {
    $str ~~ s:g/<:!L>// ;                   # scrub to ":Letter"s only
    $str = Bag.new( $str.fc.comb);          # foldcased
    for @str.sort( *.chars) {
        return $_ if $str ⊆ Bag.new( $_.fc.comb);
    }
    return '';
}

for @Test -> $str, @str, $exp {
    is func($str, @str), $exp,
            sprintf "%-8s <- %-8s <- %-20s", $exp, $str, @str.join: ' ';
}

done-testing;

my $str = 'abb cDE';
my @str =  'abcDE', 'abcde', 'ABcbde';
say "\nInput: \$str = $str\n       @str = @str[]\nOutput: ", func( $str, @str);

exit;

