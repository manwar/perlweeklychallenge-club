#!/usr/bin/perl
use warnings;
use strict;
use experimental 'signatures';

sub jumping_letters($word, @jump) {
    return join "", map {
        my $r = ord(($_ gt 'Z') ? 'a' : 'A');
        chr((ord() - $r + shift @jump) % 26 + $r)
    } split //, $word
}

use Test::More tests => 2;

is jumping_letters(Perl => 2, 22, 19, 9), 'Raku', 'Example 1';
is jumping_letters(Raku => 24, 4, 7, 17), 'Perl', 'Example 2';
