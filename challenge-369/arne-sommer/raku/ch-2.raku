#! /usr/bin/env raku

unit sub MAIN ($str is copy where $str.chars > 0,
               Int $size where $size > 0,
	       $filler where $filler.chars == 1);

my @output = gather
{
  while $str.chars >= $size
  {
    take $str.substr(0, $size);
    $str.substr-rw(0, $size) = "";
  }

  take $str ~  $filler x ($size - $str.chars) if $str.chars
}

say @output.join(", ");