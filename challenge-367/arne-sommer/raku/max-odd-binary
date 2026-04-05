#! /usr/bin/env raku

subset Binary1 where /^<[01]>+$/ && /1/;

unit sub MAIN (Binary1 $binary, :v($verbose));

my @digits = $binary.comb.sort: -*;

say ": Digits sorted: { @digits.join(", ") }" if $verbose;

@digits.push: @digits.shift;

say ": Digits w/trailing 1: { @digits.join(", ") }" if $verbose;

my $result = @digits.join;

say ": \"$result\" is max odd binary ({ $result.parse-base(2) })" if $verbose;

say $result;