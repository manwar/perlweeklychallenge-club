#! /usr/bin/env raku

unit sub MAIN (*@int where @int.elems > 0 && @int.all ~~ UInt && @int.all > 0, :v(:$verbose));

for @int.permutations.unique -> @candidate
{
  say ": Candidate: @candidate[]" if $verbose;

  my @right = @candidate.clone;
  my @left;
  
  while @right.elems > 1
  {
    @left.push: @right.shift;
    my $left-avg  = @left.sum / @left.elems;
    my $right-avg = @right.sum / @right.elems;
 
    say ": - Comparing @left[] (avg: $left-avg) <=> @right[] (avg: $right-avg)" if $verbose;

    if $left-avg == $right-avg
    {
      say 'true';
      exit;
    }
  }
}

say 'false';
