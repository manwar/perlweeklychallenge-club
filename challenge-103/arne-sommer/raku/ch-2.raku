#! /usr/bin/env raku

unit sub MAIN (Int $start, Int $current where $current > $start, $file where $file.IO.f && $file.IO.r, :v(:$verbose));

my @duration;
my @title;

my $start-ms   = $start   * 1000;
my $current-ms = $current * 1000;

for $file.IO.lines -> $line
{
  my ($time, $title) = $line.split(",", 2);

  @duration.push: $time;
  @title.push: $title;
}

my $time-ms = $start-ms;
my $title   = 0;

LOOP: loop
{
  for ^@duration.elems -> $index
  {
    $title = $index;

    last LOOP if $time-ms + @duration[$index] > $current-ms;

    $time-ms += @duration[$index];

    say ": $time-ms starting @title[$index]" if $verbose;
  }
}

say @title[$title];

my $d = ($current-ms - $time-ms) / 1000;

my ($sec, $min, $hour) = $d.polymod(60,60);

say "{ $hour.fmt('%02d') }:{ $min.fmt('%02d') }:{ $sec.fmt('%02d') }";
