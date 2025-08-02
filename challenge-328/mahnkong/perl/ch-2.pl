use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run($string) {
    while (1) {
        my $modified = 0;
        for my $c ("a" .. "z") {
            foreach my $v (uc($c).$c, $c.uc($c)) {
                if ($string =~ /$v/) {
                    $string =~ s/$v//;
                    $modified = 1;
                    last;
                }
            }
            last if $modified;
        }
        last unless $modified;
    }
    return $string;
}

is(run("WeEeekly"), "Weekly", "Example 1");
is(run("abBAdD"), "", "Example 2");
is(run("abc"), "abc", "Example 3");
