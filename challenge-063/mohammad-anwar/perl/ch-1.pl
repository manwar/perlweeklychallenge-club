#!/usr/bin/perl

use strict;
use warnings;

use Test::More;

is(last_word('  hello world',                qr/[ea]l/),      'hello');
is(last_word("Don't match too much, Chet!",  qr/ch.t/i),      'Chet!');
is(last_word("spaces in regexp won't match", qr/in re/),      undef);
is(last_word( join(' ', 1..1e6),             qr/^(3.*?){3}/), '399933');

done_testing;

sub last_word {
    my ($string, $regex) = @_;

    return [ grep /$regex/, reverse ( split /\s/, $string ) ]->[0];
}
