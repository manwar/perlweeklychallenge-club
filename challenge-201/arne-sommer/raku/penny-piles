#! /usr/bin/env raku

unit sub MAIN (UInt $n, :v(:$verbose));

my $piles := gather
{
  recurse( (), +$n);
}

sub recurse (@done, $todo)
{
  if $todo == 0
  {
    say ": @done[]" if $verbose;
    take @done;
    return;
  }

  for 1 .. $todo -> $i
  {
    last if @done && $i > @done.head;
    my @next = @done.clone;
    @next.unshift: $i;
    recurse(@next, $todo - $i);
  }
}

say $piles.elems;
