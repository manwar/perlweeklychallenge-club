#! /usr/bin/env raku

unit sub MAIN (Str $s, :v(:$verbose));

my @s    = $s.comb;
my $freq = @s.Bag;

for ^@s.elems -> $index
{
  my $char  = @s[$index];
  my $count = $freq{$char};

  say ": Char $char with frequency $count" if $verbose;

  if $count == 1
  {
    say $index;
    last;
  }
}
