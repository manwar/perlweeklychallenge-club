#!/usr/bin/perl

use v5.36;

use Test::More tests => 5;

sub count_words {
    grep {
        my $word = $_;
        ! grep { index($word, $_) >= 0 } @{ $_[1] };
    } split / /, lc $_[0];
}

is(count_words('Hello World',          ['d']),        1);
is(count_words('apple banana cherry',  [ 'a', 'e' ]), 0);
is(count_words('Coding is fun',        []),           3);
is(count_words('The Weekly Challenge', [ 'a', 'b' ]), 2);
is(count_words('Perl and Python',      ['p']),        1);
