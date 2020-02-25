#! /usr/bin/env raku

use Time::Repeat::HHMM;

unit sub MAIN (:$verbose,
               :$guest-book where $guest-book.IO.r = "guest-book.txt");

my $from;
my $to;

for $guest-book.IO.lines -> $line
{
  die "Wrong file format" unless $line ~~ /IN \: \s+ (\d\d) \: (\d\d) \s+ OUT \: \s+ (\d\d) \: (\d\d)/;

  my $current-from = "$0$1";
  my $current-to   = "$2$3";

  say "- Line (from: $current-from to: $current-to)" if $verbose;

  if ! $from.defined
  {
    $from = $current-from;
    $to   = $current-to;
  }
  else
  {
    $to = $current-to if $current-to > $to;
  }
}

say "From: $from to: $to" if $verbose;

my $from-o = Time::Repeat::HHMM.new($from);
my $to-o   = Time::Repeat::HHMM.new($to);

my $diff = $to-o.Real - $from-o.Real;

say "The light was ON for $diff minutes.";
