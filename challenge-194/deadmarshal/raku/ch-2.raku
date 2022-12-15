sub frequency-equalizer($str)
{
  my %hash;
  %hash{$_}++ for $str.comb;
  my @vals = %hash.values.sort: {$^b <=> $^a};
  @vals[0] == @vals[1]+1 && @vals[*-1] == @vals[1] ?? True !! False;
}

say frequency-equalizer('abbc');
say frequency-equalizer('xyzyyxz');
say frequency-equalizer('xzxz');

