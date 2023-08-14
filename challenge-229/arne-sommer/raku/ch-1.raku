#! /usr/bin/env raku

unit sub MAIN (*@str where @str.elems > 0, :v(:$verbose));

sub is-lexi-sorted ($string)
{
  return True if [<=] $string.ords;
  return         [>=] $string.ords;
}

say ": OK: { @str.grep( *.&is-lexi-sorted ).map('"' ~ * ~ '"').join(", ") }"
  if $verbose;

my @not-ok = @str.grep( ! *.&is-lexi-sorted );

say ": Not OK: { @not-ok.map('"' ~ * ~ '"').join(", ") }" if $verbose;

say @not-ok.elems;
