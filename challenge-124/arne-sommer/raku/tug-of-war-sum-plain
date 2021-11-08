#! /usr/bin/env raku

unit sub MAIN (*@n where @n.elems > 0   &&
                         all(@n) ~~ Int &&
                         @n.elems == @n.unique.elems);

my $best = Inf;
my @subset1;
my $sum  = @n.sum;

for @n.combinations(@n.elems / 2) -> @first
{
  my @second = (@n (-) @first).keys.sort;
   
  my $difference = ($sum - @first.sum).abs;

  if $difference < $best
  {
    $best = $difference;
    @subset1 = @first;
    
    last if $best == 0;
  }
}

say "Subset 1 = ({ @subset1.join(", ") })";
say "Subset 2 = ({ (@n (-) @subset1).keys.sort.join(", ") })";
