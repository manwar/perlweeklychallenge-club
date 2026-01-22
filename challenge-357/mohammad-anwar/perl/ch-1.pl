#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;

my @examples = (
    { in => 3524, out => 3  },
    { in => 6174, out => 0  },
    { in => 9998, out => 5  },
    { in => 1001, out => 4  },
    { in => 9000, out => 4  },
    { in => 1111, out => -1 },
);

is kaprekar_constant($_->{in}), $_->{out} for @examples;

done_testing;

sub kaprekar_constant {
    my ($int) = @_;

    my %seen;
    my $i;

    for ($i = 0; $int != 6174; $i++) {
        return -1 if $seen{$int}++;

        my $str = sprintf "%04d", $int;
        my $a   = join "", sort split //, $str;
        my $d   = reverse $a;

        $int = $d - $a;
    }

    return $i;
}
