use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run($str) {
    my @result;
    while ($str =~ /(\d+)/g) {
        push @result, $1 unless grep /^$1$/, @result;
    }
    return [ @result ];
}

is_deeply(run('the1weekly2challenge2'), [1, 2], "Example 1");
is_deeply(run('go21od1lu5c7k'), [21, 1, 5, 7], "Example 2");
is_deeply(run('4p3e2r1l'), [4, 3, 2, 1], "Example 3");
