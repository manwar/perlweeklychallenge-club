#!/usr/bin/env raku

use Test;

my @examples = (
    { in => "111000", out => 0 },
    { in => "00011",  out => 4 },
    { in => "01011",  out => 3 },
    { in => "010101", out => 3 },
    { in => "00001",  out => 4 },
);

is min-steps($_<in>), $_<out> for @examples;

done-testing;

sub min-steps(Str $str is copy) {
    my $steps = 0;
    $steps++ while $str ~~ s:g/01/10/;
    return $steps;
}
