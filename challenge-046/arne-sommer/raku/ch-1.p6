#! /usr/bin/env raku

unit sub MAIN ($string is copy = 'Hxl4! ce-lo ze6lg HWlvR q9m#o', :$verbose, :$another);

$string = 'P+2l!ato 1e80R$4u 5-r]+a>/ Pxwlb3k\ 2e35R8yu <!r^()k0' if $another;

my @strings = $string.words;
my $max     = @strings>>.chars.max;

say ": Max length: $max" if $verbose;

my @result;

for ^$max -> $index
{
  @result.push: @strings.map({ $_.substr($index,1) // "" }).repeated.unique;

  say ": Pos $index : { @strings.map({ $_.substr($index,1) // "" }) }"
    ~ " -> { @strings.map({ $_.substr($index,1) // "" }).repeated.unique }"
    if $verbose;
}

say @result.join;
