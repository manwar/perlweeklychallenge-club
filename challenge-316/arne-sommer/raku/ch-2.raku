#! /usr/bin/env raku

multi MAIN ($str1,
            $str2 where $str1.chars == $str2.chars,
            :v(:$verbose))
{
  say ": '$str1' and '$str2' have the same length" if $verbose;
  say $str1 eq $str2;
}

multi MAIN ($str1,
            $str2 where $str1.chars > $str2.chars,
            :v(:$verbose))
{
  say ": '$str1' is longer than '$str2' -> swap" if $verbose;
  MAIN($str2, $str1, :$verbose);
}

multi MAIN ($str1,
            $str2 is copy where $str1.chars < $str2.chars,
            :v(:$verbose))
{
  say ": '$str1' is shorter than '$str2' " if $verbose;

  for $str1.comb -> $char
  {
    my $i = $str2.index($char);

    unless defined $i { say False; exit; }

    say ": Split '$str2' = '$str2.substr(0,$i)' + '$char' + '$str2.substr($i +1)'" if $verbose;

    $str2 = $str2.substr($i +1);
  }

  say True;
}
