#! /usr/bin/env raku

multi sub MAIN ($file where $file.IO.f && $file.IO.r, :$csv = False)
{
  line-counter($file.IO.lines.Bag, $csv);
}

multi sub MAIN (:$csv = False)
{
  line-counter($*ARGFILES.lines.Bag, $csv);
}

sub line-counter (%input, $csv)
{
  my $max = %input.keys>>.chars.max;
  
  for %input.keys.sort({ %input{$^b} <=> %input{$^a} || $^a cmp $^b })
  {
    say $csv
      ?? "$_,%input{$_}"
      !! "{ $_ }{ " " x ($max - .chars) } { %input{$_} }";
  }    
}
