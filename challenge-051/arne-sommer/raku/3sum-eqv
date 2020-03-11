#! /usr/bin/env raku

unit sub MAIN (Int $target, *@int);

my @values = @int || (-25,-10,-7,-3,2,4,8,10);

die "Integers only" unless all(@values) ~~ Int;

for @values.combinations(3).grep(*.sum == $target).unique(:with(&[eqv])) -> @curr
{
  say "Triplet: { @curr.sort.join(", ") } = $target";
}
