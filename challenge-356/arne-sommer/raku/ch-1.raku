#! /usr/bin/env raku

unit sub MAIN (UInt $int where $int > 3, :v(:$verbose));

my $kolakoski := gather
{
  take 1;
  take 22;

  my @length = (2,);
  my $curr   = 1;
  
  loop
  {
    my $count = @length.shift;

    if $count == 1
    {
      take $curr;
      @length.push($curr);
    }
    else # $count == 2
    {
      take "$curr$curr".Int;
      @length.append($curr, $curr);
    }

    $curr = $curr == 1 ?? 2 !! 1;
  }
}

my $seq  = $kolakoski[^$int];
my @ones = $seq.grep( * == 1 | 11 );

if $verbose
{
  say ": Sequence: { $seq.raku }";
  say ": Ones:     { @ones.raku }";
}

say @ones.elems;
