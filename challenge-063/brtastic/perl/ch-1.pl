use v5.24;
use warnings;

sub last_word
{
	my ($string, $regexp) = @_;
	my @words = split /\s+/, $string;

	foreach (reverse @words) {
		return $_ if /$regexp/;
	}

	return;
}

use Test::More;

is last_word('  hello world',                qr/[ea]l/), 'hello';       # 'hello'
is last_word("Don't match too much, Chet!",  qr/ch.t/i), 'Chet!';       # 'Chet!'
ok !defined last_word("spaces in regexp won't match", qr/in re/);       #  undef
is last_word( join(' ', 1..1e6),             qr/^(3.*?){3}/), '399933'; # '399933'

done_testing;
