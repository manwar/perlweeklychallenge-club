#!/usr/bin/perl

use Test2::V0;

sub last_word {
	local $_ = shift;
	my $re = shift;
	/$re/ and return $_ foreach reverse /(?!<\S)(\S+)(?!\S)/g;
	undef;
}


is last_word('  hello world', qr/[ea]l/), 'hello', 'ex 1';
is last_word("Don't match too much, Chet!",  qr/ch.t/i), 'Chet!', 'ex 2';
is last_word("spaces in regexp won't match", qr/in re/), U(), 'ex 3';
is last_word( join(' ', 1..1e6),             qr/^(3.*?){3}/), '399933', 'ex 4';
is last_word(' leading', qr/^$/), U(), 'leading space';
is last_word('trailing ', qr/^$/), U(), 'trailing space';

done_testing;
