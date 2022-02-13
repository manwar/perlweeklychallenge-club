#! /usr/bin/env raku

unit sub MAIN (*@valuables where @valuables.elems && all(@valuables) ~~ Numeric, :v(:$verbose));

my $seq := gather { recurse( (0,), 0, @valuables.elems -1); }

sub recurse(@done is copy, $index, $todo is copy)
{
  if $todo < 2
  {
    say ": Added candidate: @done[]" if $verbose;
    take @done;
    return;
  }

  for 2, 3 -> $add
  {
    if $todo >= $add
    {
      my @done1 = @done.clone;
      @done1.push: $index + $add;
      recurse(@done1, $index + $add, $todo - $add);
    }
  }
}
    
my @candidates = $seq;

if $verbose
{
  for @candidates -> @list
  {
    say ": Candidate indices: [{ @list.join(",") }] with sum: { @valuables[@list].sum }";
  }
}

say @candidates.map({ @valuables[@$_].sum }).max;
