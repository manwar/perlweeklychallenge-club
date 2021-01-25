#!/usr/bin/perl
use warnings;
use strict;

my $ALPHABET = join "", 'A' .. 'Z';
sub caesar_cipher {
    my ($s, $n) = @_;
    $n %= 26;
    my $key = $ALPHABET;
    substr $key, 0, 0, substr $key, -$n, $n, "";
    eval "\$s =~ tr/$ALPHABET/$key/";
    return $s
}

use Test::More tests => 3;

is caesar_cipher('THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG', 3),
    'QEB NRFZH YOLTK CLU GRJMP LSBO QEB IXWV ALD',
    'Example';

is caesar_cipher('ZABC', 54), 'XYZA', 'N>26';
is caesar_cipher('YZAB', -1), 'ZABC', 'N<0';
