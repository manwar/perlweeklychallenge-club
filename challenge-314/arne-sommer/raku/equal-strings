#! /usr/bin/env raku

unit sub MAIN ($s1 where $s1.chars > 0,
               $s2 where $s2.chars > 0,
               $s3 where $s3.chars > 0,
               :v(:$verbose));

my @length = ($s1.chars, $s2.chars, $s3.chars);
my $min    = @length.min;
my $max    = @length.max;

if $min == $max
{
  if ($s1 eq $s2 eq $s3)
  {
    say ": Same lenght, and all are equal" if $verbose;
    say '0';
  }
  elsif $s1.substr(0,$min -1) eq $s2.substr(0,$min -1) eq $s3.substr(0,$min -1)
  {
    say ": Same length, and all are equal when we drop the last character" if $verbose;
    say '3';
  }
  else
  {
    say ": Same length, but they are not equal" if $verbose;
    say '-1';
  }
}
elsif $max - $min > 1
{
  say ": Longest string is more than 1 character longer than the shortest" if $verbose;
  say '-1';
}
elsif $s1.substr(0,$min) eq $s2.substr(0,$min) eq $s3.substr(0,$min)
{
  say ": Different length, but equal when we drop the last character in the long ones" if $verbose;
  say @length.sum - ($min * 3);
}
else
{
  say ": Different length (min = max-1), dropping off 1 character does not help" if $verbose;
  say '-1';
}
