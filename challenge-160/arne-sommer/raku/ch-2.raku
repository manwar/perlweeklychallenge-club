#! /usr/bin/env raku

unit sub MAIN (*@n where @n.elems > 0 && all(@n) ~~ /^\d+$/, :v(:$verbose));

my $elems = @n.elems;

for 1 .. $elems - 2 -> $equilibrium
{
  my @first  = @n[0 .. $equilibrium -1];
  my @second = @n[$equilibrium +1 .. $elems -1];

  say ": @first[] :: @second[]" if $verbose;

  if @first.sum == @second.sum
  {
    say $equilibrium;
    exit;
  }
}

say -1;

