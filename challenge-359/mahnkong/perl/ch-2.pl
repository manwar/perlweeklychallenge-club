use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run($word) {
    $word =~ s/(.)\1//g while $word =~ /(.)\1/;
    return $word;
}

is(run('aabbccdd'), '', 'Example 1');
is(run('abccba'), '', 'Example 2');
is(run('abcdef'), 'abcdef', 'Example 3');
is(run('aabbaeaccdd'), 'aea', 'Example 4');
is(run('mississippi'), 'm', 'Example 5');
