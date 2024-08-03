#!usr/bin/env raku

sub count-asterisks($str)
{
  my @arr = $str.split('|');
  (@arr[0,2...@arr.end]).comb(/\*/).elems
}

say count-asterisks('p|*e*rl|w**e|*ekly|');
say count-asterisks('perl');
say count-asterisks('th|ewe|e**|k|l***ych|alleng|e');

