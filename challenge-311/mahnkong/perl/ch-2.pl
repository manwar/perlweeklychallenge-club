use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run($str, $int) {
    while (length($str) > $int) {
        my $result;
        foreach my $substr (unpack("(A$int)*", $str)) {
            my $sum = 0;
            foreach my $c (split //, $substr) {
                $sum += $c;
            }
            $result .= "$sum";
        }
        $str = $result;
    }
    return $str;
}

is(run("111122333", 3), "359", "Example 1");
is(run("1222312", 2), "76", "Example 2");
is(run("100012121001", 4), "162", "Example 3");
