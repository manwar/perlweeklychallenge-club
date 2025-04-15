use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run($str1, $str2) {
    return join('', sort { $a cmp $b } split //, $str1)
      eq join('', sort { $a cmp $b } split //, $str2)
    || 0;
}

is(run("desc", "dsec"), 1, "Example 1");
is(run("fuck", "fcuk"), 1, "Example 2");
is(run("poo", "eop"), 0, "Example 3");
is(run("stripe", "sprite"), 1, "Example 4");
