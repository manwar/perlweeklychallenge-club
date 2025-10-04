#!perl

require './ch-2.pl';

use Test2::V0;

is rev_prefix(programming   => 'g'), 'gorpramming';
is rev_prefix(hello         => 'h'), 'hello',
is rev_prefix(abcdefghij    => 'h'), 'hgfedcbaij';
is rev_prefix(reverse       => 's'), 'srevere';
is rev_prefix(perl          => 'r'), 'repl';

is rev_prefix('', ''), '';
is rev_prefix('a','a'), 'a';

# hack3r?
ok lives { rev_prefix('test', qr/(?{ die "u got pwned" })/) };

done_testing;
