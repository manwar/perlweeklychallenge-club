#! /usr/bin/env perl6

sub MAIN (*@strings where @strings.elems >= 2)
{
  my %common = substrings( @strings.shift );

  %common = %common ∩ substrings($_) for @strings;

  .say for %common.keys.grep({ .chars == %common.keys>>.chars.max });
}


sub substrings ($string)
{
  my %substrings;
  
  for ^$string.chars -> $i
  {
    for 1 .. $string.chars - $i -> $j
    {
      %substrings{ $string.substr($i, $j) } = True;
    }
  }
  return %substrings;
}
