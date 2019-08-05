#! /usr/bin/env perl6

multi sub MAIN (*@strings, :$columns = 80)
{
  greedy-wrap(@strings, :$columns)
}

multi sub MAIN ($file where $file.IO.e && $file.IO.r, :$columns = 80)
{
  greedy-wrap($file.IO.lines, :$columns)
}

sub greedy-wrap (*@strings, :$columns = 80)
{
  my $out = "";

  sub flush
  {
    if $out
    {
      say $out;
      $out = "";  
    }
  }
  
  for @strings -> $string
  {
    if $string eq ""
    {
      flush;
      print "\n";
    }
    
    for $string.split(/\s+/) -> $word
    {
      flush if $out.chars + 1 + $word.chars >= $columns;
      
      $out = $out ?? "$out $word" !! $word;
    }
  }
  flush;
}
