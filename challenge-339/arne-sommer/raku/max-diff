#! /usr/bin/env raku

unit sub MAIN (*@ints where @ints.elems >= 4 && all(@ints) ~~ Int,
               :v(:$verbose));

my $max = -Inf;

for @ints.combinations(4) -> @comb
{
  for (@comb.permutations)[0,2,4] -> @perm
  {  
    my $diff = (( @perm[0] * @perm[1] ) - ( @perm[2] * @perm[3] )).abs;

    print ": (@perm[0] * @perm[1]) - (@perm[2] * @perm[3]) = $diff" if $verbose;
  
    if ($diff > $max)
    {
      $max = $diff;
      say " (new max)" if $verbose;
    }
    elsif $verbose
    {
      say '';
    }
  }
}
say $max;
