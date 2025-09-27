#! /usr/bin/env raku

unit sub MAIN ($str is copy where $str.chars > 0,
               :v(:$verbose));

my $index = 0;

loop
{
  last if $index >= $str.chars -1;

  if $str.substr($index,1) eq $str.substr($index +1,1)
  {
    say ": Index $index: Remove '{ $str.substr($index,2) }'" if $verbose;
    $str.substr-rw($index,2) = "";
    $index-- unless $index == 0;
  }
  else
  {
    say ": Index $index: Do nothing with '{ $str.substr($index,2) }'" if $verbose;
    $index++;
  }
}

say $str;
