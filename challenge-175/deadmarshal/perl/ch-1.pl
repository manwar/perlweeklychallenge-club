#!/usr/bin/env perl
use strict;
use warnings;
use DateTime;

die "No arg(s) provided or is not numeric with 4 digits!"
  unless defined $ARGV[0] && $ARGV[0] =~ /\d{4}/;

sub last_sunday{
  my ($year) = @_;
  foreach(1..12){
    my $dt = DateTime->last_day_of_month(year => $year, month => $_);
    while($dt->day_of_week != 7){
      $dt = $dt->subtract(days => 1);
    }
    my $date = $dt->date;
    print "$date\n";
  }
}

last_sunday($ARGV[0]);

