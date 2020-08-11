#!/usr/bin/perl

use strict;
use warnings;

use Test::More;
use Test::Deep;

my $unit_tests = [
    { in => [ "alphabet", "book", "carpet", "cadmium", "cadeau", "alpine" ],
     out => [ "alph", "b", "car", "cadm", "cade", "alpi" ]
    }
];

foreach my $unit_test (@$unit_tests) {
    my $in  = $unit_test->{in};
    my $out = $unit_test->{out};
    is_deeply(shortest_unique_prefix($in), $out);
}

done_testing;

sub shortest_unique_prefix {
    my ($words) = @_;

    my $p = [];
    foreach my $word (@$words) {
        my $i = 1;
        my $l = length($word);
        while ($i < $l) {
            my $char  = substr($word, 0, $i);
            my $count = scalar(grep { m/^$char/ } @$words);

            ($count > 1) && $i++ and next;
            push @$p, $char and last;
        }
    }

    return $p;
}
