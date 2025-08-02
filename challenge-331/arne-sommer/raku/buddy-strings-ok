#! /usr/bin/env raku

unit sub MAIN ($source where $source.chars > 0,
               $destination where $destination.chars > 0,
               :v(:$verbose));

if $destination.chars != $source.chars
{
  say ": Different string lengths; { $source.chars } vs { $destination.chars }"
    if $verbose;
  say False;
}
else
{
  my @pairs = $source.comb Z $destination.comb;
  say ": Pairs: { @pairs.raku }" if $verbose;

  my @changes = @pairs.grep({ $_[0] ne $_[1] });
  say ": Pairs with changes: { @changes.raku }" if $verbose;

  if @changes.elems == 2
  {
    say @changes[0][0] eq @changes[1][1] &&
        @changes[1][1] eq @changes[0][0];
  }
  elsif @changes.elems == 0 && $source.comb.repeated.elems
  {
    say ": Identical strings, but we can swap duplicates" if $verbose;
    say True;
  }
  else
  {
    say ": Not two pairs of letters that differ, got { @changes.elems}" if $verbose;
    say False;
  }
}
