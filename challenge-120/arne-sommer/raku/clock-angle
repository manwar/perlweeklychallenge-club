#! /usr/bin/env raku

unit sub MAIN (Str $T, :v(:$verbose));

grammar HHMM
{
  token TOP { <HH> \: <MM> }
  token HH  { <[01]> <[0..9]>  <?{ $/.Int <= 12 }> }
  token MM  { <[0..5]> <[0..9]> }
}

my $m = HHMM.parse($T) // die "Illegal HH:MM value";

my $hour = $m<HH>;
my $min  = $m<MM>;

$hour -= 12 if $hour >= 12;

my $degrees_h = 360 / 12 * $hour + $min / 2;
my $degrees_m = 360 / 60 * $min;

if $verbose
{
  say ": Hours: $hour - Degrees: $degrees_h";
  say ": minutes: $min - Degrees: $degrees_m";
}

my $diff = abs($degrees_h - $degrees_m);

say "$diff degree";
