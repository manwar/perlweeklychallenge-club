#! /usr/bin/env raku

unit sub MAIN ($s where $s ~~ /^<[ID]>+$/, :v(:$verbose));

my @output;
my @integers = (0 .. $s.chars);

for $s.comb -> $char
{
  if $char eq "I"
  {
    @output.push: @integers.shift;
    say ":I -> lowest integer { @output.tail }" if $verbose;
  }
  else
  {
    @output.push: @integers.pop;
    say ":D -> highest integer { @output.tail }" if $verbose;
  }
}

@output.push: @integers[0];
say ":  -> remaining integer { @output.tail }" if $verbose;

say "({ @output.join(", ") })";
