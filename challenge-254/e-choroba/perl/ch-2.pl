#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub reverse_vowels($s) {
    my @vowels = $s =~ /[aeiou]/gi;
    $s =~ s{([aeiou])}{
        my $v = pop @vowels;
        $1 ge 'a' ? lc $v : uc $v
    }ige;
    return $s
}

use Test::More tests => 4;

is reverse_vowels('Raku'),  'Ruka',  'Example 1';
is reverse_vowels('Perl'),  'Perl',  'Example 2';
is reverse_vowels('Julia'), 'Jaliu', 'Example 3';
is reverse_vowels('Uiua'),  'Auiu',  'Example 4';
