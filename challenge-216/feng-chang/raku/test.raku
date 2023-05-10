#!/bin/env raku

# The Weekly Challenge 216
use Test;

sub pwc-test(Str:D $script, *@input) {
    my ($expect, $assertion) = @input.splice(*-2, 2);
    my $p = run $script, |@input, :out;
    is $p.out.slurp(:close).chomp, $expect, $assertion;
}

# Task 1, Registration Number
pwc-test './ch-1.raku',
    |<abc abcd bcd>,    'AB1 2CD',
    "'abcd'",
    "Registration Number: @words = ('abc', 'abcd', 'bcd'),    \$reg = 'AB1 2CD' => 'abcd'";
pwc-test './ch-1.raku',
    |<job james bjorg>, '007 JB',
    "'job', 'bjorg'",
    "Registration Number: @words = ('job', 'james', 'bjorg'), \$reg = '007 JB'  => 'job', 'bjorg'";
pwc-test './ch-1.raku',
    |<crack road rac>, 'C7 RA2',
    "'crack', 'rac'",
    "Registration Number: @words = ('crack', 'road', 'rac'),  \$reg = 'C7 RA2'  => 'crack', 'rac'";

# Task 2, Word Stickers
pwc-test './ch-2.raku', |<perl raku python>,   'peon',          2, 'Word Stickers: @stickers = ("perl","raku","python"),   $word = "peon"          => 2';
pwc-test './ch-2.raku', |<love hate angry>,    'goat',          3, 'Word Stickers: @stickers = ("love","hate","angry"),    $word = "goat"          => 3';
pwc-test './ch-2.raku', |<come nation delta>,  'accommodation', 4, 'Word Stickers: @stickers = ("come","nation","delta"),  $word = "accommodation" => 4';
pwc-test './ch-2.raku', |<come country delta>, 'accommodation', 0, 'Word Stickers: @stickers = ("come","country","delta"), $word = "accommodation" => 0';

done-testing;
