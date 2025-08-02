#!/usr/bin/perl -s

use v5.24;
use Test2::V0;
use Unicode::Normalize;
use utf8;
use experimental 'refaliasing';

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV == 1;
usage: $0 [-examples] [-tests] [STR]

-examples
    run the examples from the challenge
 
-tests
    run some tests

STR
    a string

EOS


### Input and Output

say reverse_vowels(shift);


### Implementation

sub reverse_vowels {
    my @arr = NFD(shift) =~ /\X/g;
    \(my @vow) = map /[aeiou]/i ? \$_ : (), @arr;
    \(my @up) = map /\p{Lu}/ ? \$_ : (), @vow;

    @vow[0 .. $#vow] = map lc, reverse @vow;
    @up[0 .. $#up] = map uc, @up;

    NFC(join '', @arr);
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is reverse_vowels('Raku'),  'Ruka',  'example 1';
        is reverse_vowels('Perl'),  'Perl',  'example 2';
        is reverse_vowels('Julia'), 'Jaliu', 'example 3';
        is reverse_vowels('Uiua'),  'Auiu',  'example 4';
    }

    SKIP: {
        skip "tests" unless $tests;

        is reverse_vowels('tAvowixUyez'), 'tEvuwixOyaz', 'multiple caps';
        is reverse_vowels('Öl Tuba Tür não Ähre Ångström Bär'),
            'Äl Töbå Ter näo Ãhrü Angstrum Bör', 'modified vowels';
	}

    done_testing;
    exit;
}
