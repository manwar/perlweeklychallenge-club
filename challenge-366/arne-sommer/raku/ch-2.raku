#! /usr/bin/env raku

unit sub MAIN ($time where $time  ~~ /^ <[012\?]> <[0..9\?]> ":" <[0..5\?]> <[0..9\?]> $/,
               :v(:$verbose));

my $hh-count = 1;
my $mm-count = 1;

my ($hh, $mm) = $time.split(":");

die "Illegal hour value $hh" if $hh ~~ /\d\d/ && $hh > 23;

if $hh eq "??"
{
  $hh-count = 24;
}
elsif $hh.substr(0,1) eq "?"
{
  $hh-count = $hh.substr(1,1) <= 3 ?? 3 !! 2;
}
elsif $hh.substr(1,1) eq "?"
{
  $hh-count = $hh.substr(0,1) == 2 ?? 4 !! 10;
}

if $mm eq "??"
{
  $mm-count = 60;
}
elsif $mm.substr(0,1) eq "?"
{
  $mm-count = 6;
}
elsif $mm.substr(1,1) eq "?"
{
  $mm-count = 10;
}

if $verbose
{
  say ": HH: $hh count: $hh-count";
  say ": MM: $mm count: $mm-count";
}

say $hh-count * $mm-count;
