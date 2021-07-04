use v6;

sub SwapNibbles {
 # Convert int to base 2
  my $b = $^a.base(2);
 # Turn string into list of nibbles
  my $blen = $b.chars;
  my $wlen = 2 ** log($blen,2).ceiling;
  my $w = "0" x $wlen-$blen ~ $b;
  my @nibbles = $w.chop(4),$w.flip.chop(4).flip;
 # Swap (reverse or rotate) nibbles
  my $result = @nibbles.reverse.join;
 # Convert back to decimal
  $result.parse-base(2).Int;
}

say 86 == SwapNibbles 101;
say 33 == SwapNibbles 18;
