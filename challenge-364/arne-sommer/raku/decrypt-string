#! /usr/bin/env raku

unit sub MAIN ($string where $string.chars > 0, :v(:$verbose));

my $tokens := gather
{
  my @chars = $string.comb;

  while @chars.elems
  {
    if @chars.elems > 2 && @chars[2] eq '#'
    {
      say ": '{ @chars.join }' -> take '{ @chars[0..2].join }'" if $verbose;
      take (@chars.shift ~ @chars.shift ~ @chars.shift).substr(0,2);
    }
    else
    {
      say ": '{ @chars.join }' -> take '@chars[0]'" if $verbose;
      take @chars.shift;
    }
  }
}

say $tokens.map({ .&decrypt }).join;

sub decrypt ($key)
{
  constant base = 'a'.ord -1;

  return (base + $key).chr;
}
