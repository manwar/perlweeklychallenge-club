#! /usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use File::Slurp;
use Date::Calc;

my $verbose = 0;

GetOptions("verbose"  => \$verbose);

my $file = shift(@ARGV) || "temperature.txt";
my @rows = read_file($file, chomp => 1);

my %measures;

for my $row (@rows)
{
  my ($date, $temperature) = split(", ", $row);

  $measures{$date} = $temperature;
}

for my $date (sort keys %measures)
{
  my $prev      = sprintf("%04d-%02d-%02d", Date::Calc::Add_Delta_Days(split("-", $date), -1));
  my $temp      = $measures{$date};
  my $prev_temp = $measures{$prev};

  print ": Checking Date: $date (temp: $temp)" if $verbose;

  if (defined $prev_temp)
  {
    say " - $prev (temp $prev_temp)" if $verbose;
    say $date if $temp > $prev_temp;
  }
  elsif ($verbose)
  {
    say "";
  }
}
