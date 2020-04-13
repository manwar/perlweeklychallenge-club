#!/usr/bin/env raku

multi postcircumfix:<[ ]> (Str $_, Range \ran) { .substr(ran) }

my $num = “010”;
my %flips;

for ^$num.chars -> $L {
    for $L..^$num.chars -> $R {
    	%flips{“$L\t$R”} = +($num[^$L] ~ (TR/01/10/ given $num[$L..$R]) ~ $num[$R^..*]).comb.grep: 1
    }
}

say .key for %flips.grep: *.value == max %flips.values
