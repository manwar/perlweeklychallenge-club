#!/bin/env raku

unit sub MAIN(*@ints);

my @names = <zero one two three four five six seven eight
nine ten eleven twelve thirteen fourteen fifteen sixteen
seventeen eighteen nineteen twenty thirty forty fifty
sixty seventy eighty ninety>;

multi sub spell-number(Int $n where * < 0)          { 'minus ' ~ spell-number(-$n) }

multi sub spell-number(Int $n where * < 20)         { @names[$n] }

multi sub spell-number(Int $n where * < 100)        {
    my $r = @names[$n / 10 + 18];
    $r ~= '-' ~ @names[$n % 10] if $n % 10;

    $r
}

multi sub spell-number(Int $n where * < 1000)       { spell-part($n, 100,  'hundred')  }
multi sub spell-number(Int $n where * < 1_000_000)  { spell-part($n, 1000, 'thousand') }

sub spell-part(Int $n, Int $base, Str $name) {
    my $r = spell-number(($n / $base).Int) ~ ' ' ~ $name;
    $r ~= ' and ' ~ spell-number($n % $base) if $n % $base;

    $r
}

put @ints.sort({ spell-number($_) });
