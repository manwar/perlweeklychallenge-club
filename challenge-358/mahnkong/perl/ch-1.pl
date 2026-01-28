use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run(@strings) {
    my $result = undef;
    foreach my $string (@strings) {
        my $current = $string =~ /\D/ ? length($string) : $string;
        $result = $current if !defined $result || $current > $result;
    }
    return $result;
}

is(run('123','45','6'), 123, 'Example 1');
is(run('abc','de','fghi'), 4, 'Example 2');
is(run('0012','99','a1b2c'), 99, 'Example 3');
is(run('x','10','xyz','007'), 10, 'Example 4');
is(run('hello123','2026','perl'), 2026, 'Example 5');
