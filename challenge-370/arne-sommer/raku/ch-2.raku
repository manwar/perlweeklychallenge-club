#! /usr/bin/env raku

unit sub MAIN ($str1,
               $str2 where $str1.chars == $str2.chars > 0,
               :v(:$verbose));

my $anagrams = $str1.comb.sort.join eq $str2.comb.sort.join;

if $anagrams
{
  my $scrambled := gather
  {
    scramble($str1);
  }

  for $scrambled -> $candidate
  {
    say ": Candidate: $candidate" if $verbose;
    if $candidate eq $str2
    {
      say True;
      exit;
    }
  }
}
elsif $verbose
{
  say ": Not anagrams";
}

say False;

sub scramble ($str)
{
  take $str;

  return if $str.chars == 1;

  for 1 .. $str.chars -1 -> $i
  {
    my @s1 = gather { scramble($str.substr(0, $i)); }
    my @s2 = gather { scramble($str.substr($i)); }
    
    for @s1 -> $s1
    {
      take $s1 ~ $str.substr($i);
      take $str.substr($i) ~ $s1; 
      for @s2 -> $s2
      {
        take $s1 ~ $s2;
        take $s2 ~ $s1;
      }
    }
    for @s2 -> $s2
    {
      take $str.substr(0, $i) ~ $s2;
      take $s2 ~ $str.substr(0, $i);
    }
  }
}