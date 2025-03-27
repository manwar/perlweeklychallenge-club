use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run(@list) {
    my $unsorted = 0;
    for (my $i = 0; $i < length($list[0]); $i++) {
        my @l;
        foreach my $str (@list) {
            push @l, substr($str, $i, 1);
        }
        $unsorted += 1 if join("", @l) ne join("", sort { $a cmp $b } @l);
    }
    return $unsorted;
}

is(run("swpc", "tyad", "azbe"), 2, "Example 1");
is(run("cba", "daf", "ghi"), 1, "Example 2");
is(run("a", "b", "c"), 0, "Example 3");
