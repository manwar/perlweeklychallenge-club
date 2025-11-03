#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;

my @examples = (
    { in => [1, 3, 2],             exp => "1"       },
    { in => [2, 4, 6, 5, 3],       exp => "2"       },
    { in => [1, 2, 3, 2, 4, 1],    exp => "2, 4"    },
    { in => [5, 3, 1],             exp => "0"       },
    { in => [1, 5, 1, 5, 1, 5, 1], exp => "1, 3, 5" },
);

foreach (@examples) {
    is(peak_point(@{$_->{in}}), $_->{exp});
}

done_testing;

sub peak_point {
    my @n = @_;
    return join(", ", grep {
        ($_ == 0   ? @n > 1 && $n[0]  > $n[1]  :
         $_ == $#n ? @n > 1 && $n[-1] > $n[-2] :
         $n[$_] > $n[$_-1]  && $n[$_] > $n[$_+1])
    } 0..$#n);
}
