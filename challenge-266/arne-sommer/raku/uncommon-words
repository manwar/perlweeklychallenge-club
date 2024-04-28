#! /usr/bin/env raku

unit sub MAIN (*@lines where @lines.elems > 1, :v(:$verbose));

my $bag = Bag.new;

for @lines -> $line
{
  my @words = $line.words;

  $bag (+)= @words;

  say ": Bag: { $bag.raku }" if $verbose;
}

say '(' ~ $bag.grep({ $_.value == 1 }).map({ "'" ~ $_.key ~ "'" }).join(", ")  ~ ')';
