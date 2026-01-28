#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;

my @examples = (
    { in => ["123", "45", "6"],           out => 123  },
    { in => ["abc", "de", "fghi"],        out => 4    },
    { in => ["0012", "99", "a1b2c"],      out => 99   },
    { in => ["x", "10", "xyz", "007"],    out => 10   },
    { in => ["hello123", "2026", "perl"], out => 2026 },
);

is max_str_val(@{$_->{in}}), $_->{out} for @examples;

sub max_str_val {
    my @str = @_;

    my $max = 0;
    for (@str) {
        my $val = /^\d+$/ ? $_ : length $_;
        $max = $val if $val > $max;
    }

    return $max;
}

done_testing;
