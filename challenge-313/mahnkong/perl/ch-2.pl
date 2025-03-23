use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run($str) {
    my @str = split //, $str;

    my @alphanumeric;
    foreach my $c (reverse(@str)) {
        push @alphanumeric, $c if $c =~ /[a-z]/i;
    }

    my $result;
    foreach my $c (@str) {
        $result .= ($c =~ /[a-z]/i ? shift @alphanumeric : $c);
    }
    return $result;
}

is(run("p-er?l"), "l-re?p", "Example 1");
is(run("wee-k!L-y"), "yLk-e!e-w", "Example 2");
is(run("_c-!h_all-en!g_e"), "_e-!g_nel-la!h_c", "Example 3");
