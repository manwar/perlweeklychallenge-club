#! /usr/bin/env raku

subset BinaryString where /^ <[01]>+ $/;
subset PosInt of Int where * > 0;

unit sub MAIN (BinaryString $B = '101100101',
               PosInt $S where $B.chars %% $S = 3,
	       :v(:$verbose));

my @B     = $B.comb($S.Int);
my $first = @B.shift;
my $total = 0;

for @B -> $current
{
  my $flip = bit-diff($first, $current);
  $total += $flip;
  say ": $first -> $current -> Flip: $flip" if $verbose;
}

say $total;

sub bit-diff ($a, $b)
{
  my $flip = 0;

  for ^$a.chars -> $index
  {
    $flip++ if $a.substr($index,1) ne $b.substr($index,1);
  }

  return $flip;
}