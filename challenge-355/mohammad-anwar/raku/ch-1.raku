#!/usr/bin/env raku

use Test;

my %examples = Map.new(
    123     => "123",
    1234    => "1,234",
    1000000 => "1,000,000",
    1       => "1",
    12345   => "12,345"
);

for %examples.kv -> $input, $expected {
    is thousand-separator($input.Int), $expected;
}

done-testing;

sub thousand-separator(Int $num --> Str) {
    my $reversed = $num.flip;
    $reversed ~~ s:g/(\d**3) <?before \d>/$0,/;
    return $reversed.flip;
}
