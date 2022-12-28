sub move-zero(@arr)
{
  return @arr unless @arr.none != 0;
  my $count = 0;
  my @ret = @arr.grep({$_ == 0 ?? $count++ && () !! $_});
  @ret.push: 0 xx $count;
}

say move-zero([1,0,3,0,0,5]).join(' ');
say move-zero([1,6,4]).join(' ');
say move-zero([0,1,0,2,0]).join(' ');

