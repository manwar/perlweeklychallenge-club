#! /usr/bin/env raku

unit sub MAIN (*@values where @values.elems > 0, :v(:$verbose));

my @promises;

for @values -> $value
{
  next unless $value ~~ Numeric;
  @promises.push: Promise.in($value).then: { say $value; };
}

await @promises;
