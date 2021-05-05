#!/bin/env raku

grammar Phone-Number {
    regex TOP    { <prefix> \s+ <local> }
    token prefix { '+'\d\d || '('\d\d')' || \d\d\d\d }
    token local  { \d ** 10 }
}

my @numbers =
    '0044 1148820341',
    '+44 1148820341',
    '44-11-4882-0341',
    '(44) 1148820341',
    '00 1148820341';

.put if Phone-Number.parse($_) for @numbers;
