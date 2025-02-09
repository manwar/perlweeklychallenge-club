#! /usr/bin/env raku

unit sub MAIN (*@words where @words.elems > 0, :v(:$verbose));

my %canonical;

@words.map({ %canonical{$_} = $_.lc.comb.sort.join });

@words.map({ say ": Canonical of: $_ -> %canonical{$_}" }) if $verbose;

my $index = 0;

loop
{
  last if @words.elems == 0;
  last if @words.end   == $index;

  if %canonical{@words[$index + 0]} eq %canonical{@words[$index + 1]}
  {
    print ": Dropping @words[$index + 0] (index $index)" if $verbose;
    @words.splice($index,1);
    say " -> ({ @words.join(",") })" if $verbose;
  }
  else
  {
    $index++;
  }
}

say @words.elems;
