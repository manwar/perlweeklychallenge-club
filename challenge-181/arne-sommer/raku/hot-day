#! /usr/bin/env raku

unit sub MAIN ($file where $file.IO.f && $file.IO.r = "temperature.txt", :v(:$verbose));

my @rows = $file.IO.lines;

my %measures;

for @rows -> $row
{
  my ($date, $temperature) = $row.split(", ");

  %measures{$date} = $temperature;
}

for sort keys %measures -> $date
{
  my $prev      = $date.Date.pred;
  my $temp      = %measures{$date};
  my $prev_temp = %measures{$prev};

  print ": Checking Date: $date (temp: $temp)" if $verbose;

  if $prev_temp.defined
  {
    say " - $prev (temp $prev_temp)" if $verbose;
    say $date if $temp > $prev_temp;
  }
  elsif $verbose
  {
    say "";
  }
}