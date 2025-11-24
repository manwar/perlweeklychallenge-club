#!/usr/bin/env raku

use Test;

my @examples = (
    { in => "textbook"            , exp => 2 },
    { in => "aaaaa"               , exp => 5 },
    { in => "hoorayyy"            , exp => 3 },
    { in => "x"                   , exp => 1 },
    { in => "aabcccddeeffffghijjk", exp => 4 },
);

for @examples -> $ex {
    is power_string($ex<in>), $ex<exp>;
}

sub power_string(Str $s) {
    return 0 if $s.chars == 0;

    my $max   = 1;
    my $count = 1;

    for 1 ..^ $s.chars -> $i {
        if $s.substr($i,1) eq $s.substr($i-1,1) {
            $count++;
        } else {
            $max = $count if $count > $max;
            $count = 1;
        }
    }

    $max = $count if $count > $max;
    return $max;
}
