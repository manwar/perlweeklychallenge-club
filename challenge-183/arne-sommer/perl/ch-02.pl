#! /usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use File::Slurp;
use Date::Calc qw/N_Delta_YMD Delta_Days/;
use feature 'signatures';

no warnings 'experimental::signatures';

my $file = shift(@ARGV) || "dates.txt";
my @rows = read_file($file, chomp => 1);

for my $row (@rows)
{
  my ($date1, $date2) = split(/\s+/, $row);

  say "$date1 vs $date2 -> " . date_diff($date1, $date2);
}


sub date_diff ($date1, $date2)
{
    ($date1, $date2)   = ($date2, $date1) if $date1 gt $date2;
    my ($y, $m, $d)    = N_Delta_YMD(split("-", $date1), split("-", $date2));
    my ($y2, $m2, $d2) = split("-", $date1);
    my $days           = Delta_Days($y2 + $y, $m2, $d2, split("-", $date2));
    my @return;

    push(@return, plural("year", $y))   if $y;
    push(@return, plural("day", $days)) if $days;

    return "0 days" unless @return;
    
    return join(" ", @return);
  
}

sub plural ($label, $val)
{
  return "$val $label" if $val == 1;
  return "$val $label". "s";
}
