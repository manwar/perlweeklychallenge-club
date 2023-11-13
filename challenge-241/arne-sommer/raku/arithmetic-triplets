#! /usr/bin/env raku

unit sub MAIN ($diff where $diff ~~ UInt && $diff > 0,
               *@nums where @nums.elems > 2 && all(@nums) ~~ Int && ( [<] @nums ),
	       :v(:$verbose));

my $end      = @nums.end;
my $triplets = 0;

for 0 .. $end -2 -> $i
{
  for $i+1 .. $end -1 -> $j
  {
    for $j+1 .. $end -> $k
    {
      if $diff == @nums[$j] - @nums[$i] == @nums[$k] - @nums[$j]
      {
        $triplets++;
        say ":Indices: $i,$j,$k -> values: @nums[$i],@nums[$j],@nums[$k] [triplet]" if $verbose;
      }
      elsif $verbose
      {
        say ":Indices: $i,$j,$k -> values: @nums[$i],@nums[$j],@nums[$k]";
      }
    }
  }
}

say $triplets;
