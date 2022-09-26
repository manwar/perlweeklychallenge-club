#! /usr/bin/env raku

unit sub MAIN ($file where $file.IO.f && $file.IO.r = "dates.txt");

my @rows = $file.IO.lines;

for @rows -> $row
{
  my ($date1, $date2) = $row.words;

  say "$date1 vs $date2 -> " ~ date-diff($date1, $date2);
}

sub date-diff ($date1, $date2)
{
  ($date1, $date2)   = ($date2, $date1) if $date1 gt $date2;

  my $d1 = $date1.Date;
  my $d2 = $date2.Date;

  my $years = 0;

  while ( $d2 >= $d1.later(:year))
  {
    $years++;
    $d1 = $d1.later(:year);
  }

  my $days = $d2.daycount - $d1.daycount;
  my @return;
    
  push(@return, plural("year", $years)) if $years;
  push(@return, plural("day", $days))   if $days; 

  return "0 days" unless @return;
    
  return join(" ", @return); 
}

sub plural ($label, $val)
{
  return "$val $label" if $val == 1;
  return "$val $label" ~ "s";
}
