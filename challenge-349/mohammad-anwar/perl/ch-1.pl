#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;

my @examples = (
    { in => "textbook"            , exp => 2 },
    { in => "aaaaa"               , exp => 5 },
    { in => "hoorayyy"            , exp => 3 },
    { in => "x"                   , exp => 1 },
    { in => "aabcccddeeffffghijjk", exp => 4 },
);

is(power_string($_->{in}), $_->{exp}) for @examples;

done_testing;

sub power_string {
    my ($s) = @_;
    return 0 unless length $s;

    my $max   = 1;
    my $count = 1;

    for my $i (1 .. length($s)-1) {
        if (substr($s,$i,1) eq substr($s,$i-1,1)) {
            $count++;
        } else {
            $max = $count if $count > $max;
            $count = 1;
        }
    }

    $max = $count if $count > $max;
    return $max;
}
