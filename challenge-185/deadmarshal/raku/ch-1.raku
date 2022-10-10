sub mac_address(Str $str)
{
  my @arr = $str.comb.grep(none /<[.]>/);
  my @ret;
  while @arr.splice(0,2) -> $item {@ret.push($item);}
  return join ':', map {join '', @$_}, @ret;
}

say mac_address("1ac2.34f0.b1c2");
say mac_address("abc1.20f1.345a");
