sub most-frequent-even(@arr)
{
  return -1 if @arr.none %% 2;
  my %hash;
  %hash{$_}++ for @arr.grep: * %% 2;
  return %hash.keys.min if %hash.values == %hash.values.unique;
  %hash.keys.sort.reduce: {%hash{$^a} == %hash{$^b} ?? $^a !! $^b};
}

say most-frequent-even([1,1,2,6,2]);
say most-frequent-even([1,3,5,7]);
say most-frequent-even([6,4,4,6,1]);

