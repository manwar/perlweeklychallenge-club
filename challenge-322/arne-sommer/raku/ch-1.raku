#! /usr/bin/env raku

unit sub MAIN ($str is copy where $str.chars > 0,
               Int $i where $i > 0,
               :v(:$verbose));

$str ~~ s:g/"-"//;

say ": Dash free: $str" if $verbose;

my @new;

while $str.chars >= $i
{
  my $add = $str.substr($str.chars - $i);
  $str = $str.substr(0, $str.chars - $i);

  @new.unshift: $add;
  say ": Full size part: $add" if $verbose;
}

if $str.chars
{
  @new.unshift: $str;
  say ": Short part: $str" if $verbose;
}

say @new.join("-");
