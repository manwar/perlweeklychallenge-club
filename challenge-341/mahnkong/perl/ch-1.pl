use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run($string, $keys) {
    my $result = 0;
    my $keys_str = join('', @$keys);
    foreach my $word (split(' ', $string)) {
        $result += 1 if $word =~ /^[^ $keys_str]+$/i;
    }
    return $result;
}

is(run("Hello World", ['d']), 1, "Example 1");
is(run("apple banana cherry", ['a','e']), 0, "Example 2");
is(run("Coding is fun", []), 3, "Example 3");
is(run("The Weekly Challenge", ['a', 'b']), 2, "Example 4");
is(run("Perl and Python", ['p']), 1, "Example 5");
