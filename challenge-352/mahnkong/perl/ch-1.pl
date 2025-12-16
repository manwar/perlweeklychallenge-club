use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run(@words) {
    my @result;
    foreach my $w1 (@words) {
        foreach my $w2 (@words) {
            next if $w1 eq $w2;
            push @result, $w1 if $w2 =~ /$w1/ and ! grep {/^$w1$/} @result;
        }
    }
    return [ @result ];
}

is_deeply(
    run("cat", "cats", "dog", "dogcat", "dogcat", "rat", "ratcatdogcat"),
    ["cat", "dog", "dogcat", "rat"],
    "Example 1"
);

is_deeply(
    run("hello", "hell", "world", "wor", "ellow", "elloworld"),
    ["hell", "world", "wor", "ellow"],
    "Example 2"
);

is_deeply(
    run("a", "aa", "aaa", "aaaa"),
    ["a", "aa", "aaa"],
    "Example 3"
);

is_deeply(
    run("flower", "flow", "flight", "fl", "fli", "ig", "ght"),
    ["flow", "fl", "fli", "ig", "ght"],
    "Example 4"
);

is_deeply(
    run("car", "carpet", "carpenter", "pet", "enter", "pen", "pent"),
    ["car", "pet", "enter", "pen", "pent"],
    "Example 5"
);
