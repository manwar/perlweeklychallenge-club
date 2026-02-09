use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run($str, $width) {
    my $p = ($width - length($str)) / 2;
    return '*' x int($p) . $str . '*' x ($p == int($p) ? $p : int($p) + 1);
}

is(run('Hi', 5), '*Hi**', 'Example 1');
is(run('Code', 10), '***Code***', 'Example 2');
is(run('Hello', 9), '**Hello**', 'Example 3');
is(run('Perl', 4), 'Perl', 'Example 4');
is(run('A', 7), '***A***', 'Example 5');
is(run('', 5), '*****', 'Example 6');
