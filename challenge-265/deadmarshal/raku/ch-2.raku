sub completing_word($str, @strs)
{
  my $b = $str.lc.comb(/<lower>/).Bag;
  @strs.sort(*.chars).first($b (<=) *.comb.Bag) // ~Empty
}

say completing_word('aBc 11c',['accbbb','abc','abbc']);
say completing_word('Da2 abc',['abcm','baacd','abaadc']);
say completing_word('JB 007',['jj','bb','bjb']);

