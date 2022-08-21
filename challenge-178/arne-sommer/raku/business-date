#! /usr/bin/env raku

unit sub MAIN (Str $timestamp, Str $duration);

my ($duration-hour, $duration-min) = $duration.split(".")>>.Int;

$duration-min = $duration-min ?? $duration-min * 6 !! 0;

my ($ymd, $hm) = $timestamp.split(" ");

my $dt = DateTime.new($ymd ~ "T" ~ $hm ~ ":00");

die "Only 09:00-18:00 allowed" if $dt.hour < 9 || $dt.hour == 18 && $dt.minute || $dt.hour > 18;

$dt.=later([days  => $duration-hour div 9, hours => $duration-hour % 9, minutes => $duration-min]);

if $dt.hour < 9
{
  $dt.=later(hours => 9);
}
elsif $dt.hour == 18 && $dt.minute || $dt.hour > 18
{
  $dt.=later(hours => 15);
}

say $dt.yyyy-mm-dd ~ " " ~ $dt.hh-mm-ss.substr(0,5);
