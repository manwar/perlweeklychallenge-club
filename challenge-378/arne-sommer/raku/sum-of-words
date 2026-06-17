#! /usr/bin/env raku

subset AJ where /^ <[a..j]>+ $ /;

unit sub MAIN (AJ $str1, AJ $str2, AJ $str3,
               :v(:$verbose));

sub digitise (AJ $string)
{
  return $string.comb.map( *.ord - 'a'.ord ).join;
}

my $num1 = digitise($str1);
my $num2 = digitise($str2);
my $num3 = digitise($str3);

if $verbose
{
  say ": \$str1 = '$str1' = $num1";
  say ": \$str2 = '$str2' = $num2";
  say ": \$str3 = '$str3' = $num3";
}

say $num1 + $num2 == $num3;