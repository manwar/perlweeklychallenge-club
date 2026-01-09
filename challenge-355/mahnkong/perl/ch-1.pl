use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run($int) {
    return reverse(join(",", reverse($int) =~ /(.{1,3})/g));
}

is(run(123), '123', 'Example 1');
is(run(1234), '1,234', 'Example 2');
is(run(1000000), '1,000,000', 'Example 3');
is(run(1), '1', 'Example 4');
is(run(12345), '12,345', 'Example 5');
