#! /usr/bin/env raku

unit sub MAIN (*@ints is copy where @ints.elems > 0 && all(@ints) eq any(0,1),
               Int :$n where $n > 0,
               :v(:$verbose));

if @ints.join ~~ /11/
{
  say ':Found neighbourly 1s in the input' if $verbose;
  say 'false';
  exit;
}

my $replaced = 0;

for 0 .. @ints.end -> $index
{
  if @ints[$index] == 0
  {
    if $index == 0 || @ints[$index -1] == 0
    {
      if $index == @ints.end || @ints[$index +1] == 0
      {
        @ints[$index] = 1;
        $replaced++;
	
	say ": Replaced #$replaced at index $index: [{ @ints.join(",") }]" if $verbose;
      }
    }
  }
}

say $replaced >= $n ?? 'true' !! 'false';
