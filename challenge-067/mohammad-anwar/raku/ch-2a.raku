#!/usr/bin/env raku

#
# Perl Weekly Challenge - 067
#
# Task #2: Letter Phone
#
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-067/
#

use Test;

is sprintf("[ %s ]", phone-letters('35').join(", ")),
   "[ 'dj', 'dl', 'dk', 'ej', 'el', 'ek', 'fj', 'fl', 'fk' ]",
   'testing "35"';
is sprintf("[ %s ]", phone-letters('10').join(", ")),
   "[ '_0', ',0', '@0' ]",
   'testing "10"';
is sprintf("[ %s ]", phone-letters('2#').join(", ")),
   "[ 'a#', 'b#', 'c#' ]",
   'testing "2#"';

done-testing;

sub phone-letters(Str $digits where { $digits ~~ /^ <[0..9\*\#]>+ $/ }) {

    # letter phone
    my %letter-of = (
        '1' => '_,@',
        '2' => 'abc',
        '3' => 'def',
        '4' => 'ghi',
        '5' => 'jlk',
        '6' => 'mno',
        '7' => 'pqrs',
        '8' => 'tuv',
        '9' => 'wxyz',
        '0' => '0',
        '#' => '#',
        '*' => chr(9251),
    );

    # prepare data set
    my @data = $digits.comb.map({ [ %letter-of{$_}.comb ] });

    # generate all possible combinations
    return map {qq{'$_'}}, ([X~] @data);
}
