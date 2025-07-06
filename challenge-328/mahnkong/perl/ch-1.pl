use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run($str) {
    my @str = split //, $str;
    my @chars;
    push @chars, $_ for ("a" .. "z");

    for (my $i = 0; $i < scalar(@str); $i++) {
        if ($str[$i] eq '?') {
            foreach my $s (@chars) {
                unless (($str[$i - 1] && $str[$i - 1] eq $s) || ($str[$i + 1] && $str[$i + 1] eq $s)) {
                    $str[$i] = $s;
                    last
                }
            }
            next;
        }
    }
    return join('', @str);
}

is(run('a?z'), 'abz', "Example 1");
is(run('pe?k'), 'peak', "Example 2");
is(run('pe??k'), 'peabk', "Example 3");
is(run('gra?te'), 'grabte', "Example 4");
is(run('gra?t?e'), 'grabtae', "Example 5");
is(run('c????b?'), 'cabacba', "Example 6");
