use strict;
use warnings;
use experimental 'signatures';
use feature 'say';

sub interleaved($a, $b, $c) {
    ($a, $b) = ($b, $a) if length $a < length $b;
    my ($is_a, $is_b) = (0, 0);
    $c =~ s/(\Q$a\E)|\Q$b\E/ $1 and ++$is_a or ++$is_b; '' /e for 1 .. 2;
    $c eq q() && ($is_a && $is_b || $a eq $b)
}

if (@ARGV == 3) {
    say +interleaved(@ARGV);
    exit 0;
}

eval <<'EOTEST';
use Test::More tests => 15;
ok !interleaved('A', 'B', 'BB'), 'missing char from a';
ok !interleaved('A', 'B', 'AA'), 'missing char from b';
ok !interleaved('A', 'B', 'XX'), 'missing char from a,b';

ok interleaved('A', 'B', 'AB'), 'two letters v1';
ok interleaved('A', 'B', 'BA'), 'two letters v2';
ok interleaved('B', 'A', 'AB'), 'two letters v3';
ok interleaved('B', 'A', 'BA'), 'two letters v4';

ok interleaved('A', 'A', 'AA'), 'a=b';
ok interleaved('ABC', 'ABC', 'ABCABC'), 'long a=b';
ok interleaved('AAA', 'AAA', 'AAAAAA'), 'long a=b, single char';

ok interleaved('AB', 'C', 'ACB'), 'ACB basket v1';
ok interleaved('C', 'AB', 'ACB'), 'ACB basket v2';

ok interleaved('XY', 'X', 'XXY'), 'Example 1';
ok interleaved('XXY', 'XXZ', 'XXXXZY'), 'Example 2';
ok !interleaved('YX', 'X', 'XXY'), 'Example 3';

EOTEST
