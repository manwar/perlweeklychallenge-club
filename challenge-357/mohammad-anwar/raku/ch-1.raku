#!/usr/bin/env raku

use Test;

my @examples = (
    { in => 3524, out => 3  },
    { in => 6174, out => 0  },
    { in => 9998, out => 5  },
    { in => 1001, out => 4  },
    { in => 9000, out => 4  },
    { in => 1111, out => -1 },
);

is kaprekar-constant($_<in>), $_<out> for @examples;

done-testing;

sub kaprekar-constant ($int is copy) {

    my %seen;
    my $i;

    loop ($i = 0; $int != 6174; $i++) {
        return -1 if %seen{$int}++;

        my $str = sprintf "%04d", $int;
        my $a   = $str.comb.sort.join;
        my $d   = $a.flip;

        $int = $d.Int - $a.Int;
    }

    return $i;
}
