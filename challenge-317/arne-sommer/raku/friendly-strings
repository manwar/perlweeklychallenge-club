#! /usr/bin/env raku

unit sub MAIN ($str1 where $str1.chars > 1,
               $str2,
               :v(:$verbose));

if $str2.chars != $str1.chars
{
  say ": The strings do not have the same length" if $verbose;
  say False;
}

elsif $str1.comb.sort.join ne $str2.comb.sort.join
{
  say ": The strings do not have the same letters" if $verbose;
  say False;
}

elsif $str1 eq $str2
{
  my $repeated = $str1.comb.repeated;

  if $repeated
  {
    say ": The strings are identical, but have duplicate characters that can be swapped" if $verbose;
    say True;
  }
  else
  {
    say ": The strings are identical" if $verbose;
    say False;
  }
}

else 
{
  my @delta;
  for ^$str1.chars -> $index
  {
    if $str1.substr($index,1) ne $str2.substr($index,1)
    {
      @delta.push: ($str1.substr($index,1), $str2.substr($index,1) );
    }
  }

  say ": Delta: { @delta.raku }" if $verbose;

  say @delta.elems == 2;
}
