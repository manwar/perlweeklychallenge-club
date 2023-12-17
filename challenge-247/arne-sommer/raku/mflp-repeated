#! /usr/bin/env raku

unit sub MAIN (Str $s where $s ~~ /^<[a..z]>+$/, :v(:$verbose));

my $letter-pairs := gather
{
  my @s = $s.comb;

  my $first = @s.shift;
  my $taken = False;

  while @s.elems
  {
    my $second = @s.shift;
    my $pair   =  $first ~ $second;

    if $first eq $second
    {
      $taken ?? ( $taken = False ) !! ( $taken = True; take $pair );
    }
    else
    {
      $taken = False;
      take $pair;
    }

    $first = $second;
  }
}

my $bag = $letter-pairs.Bag;
my $max = $bag.values.max;
my @all = $bag.grep( *.value == $max ).map( *.key );

say ": Bag: { $bag.raku }" if $verbose;
say ": Matches: { @all.join(", ") } (with occurence $max)" if $verbose;

say @all.sort.head;
