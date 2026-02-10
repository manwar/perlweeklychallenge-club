use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run($str) {
    return join(" ", sort { lc($a) cmp lc($b) } split / +/, $str);
}

is(run('The quick brown fox'), 'brown fox quick The', 'Example 1');
is(run('Hello    World!   How   are you?'), 'are Hello How World! you?', 'Example 2');
is(run('Hello'), 'Hello', 'Example 3');
is(run('Hello, World! How are you?'), 'are Hello, How World! you?', 'Example 4');
is(run('I have 2 apples and 3 bananas!'), '2 3 and apples bananas! have I', 'Example 5');
