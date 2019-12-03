#! /usr/bin/perl

use strict;
use warnings;

use Astro::Coord::ECI;
use Astro::Coord::ECI::Sun;
use Astro::Coord::ECI::Utils qw{deg2rad};
use Time::Local;

my $year=2019;

my ($lat,$lon,$alt)=(deg2rad(51.507222),deg2rad(-0.1275),11);

my @dtime;
my $sun=Astro::Coord::ECI::Sun->new;

foreach my $month (11,12) {
  my $ts=timelocal(0,0,0,1,$month-1,$year);
  my $te;
  {
    my $mm=$month+1;
    my $yy=$year;
    if ($mm>12) {
      $mm-=12;
      $yy++;
    }
    $te=timelocal(0,0,0,1,$mm-1,$yy);
  }
  my $sta=Astro::Coord::ECI->
    universal($ts)->
    geodetic($lat,$lon,$alt);
  my $ds=0;
  my $ls=0;
  foreach my $event ($sun->almanac($sta,$ts,$te)) {
    if ($event->[1] eq 'horizon') {
      my $t=localtime($event->[0]);
      if ($event->[2] == 1) {
        $ls=$event->[0]
      } else {
        if ($ls) {
          $ds+=$event->[0]-$ls;
        }
      }
    }
  }
  push @dtime,$ds;
}

print 'delta ',$dtime[1]-$dtime[0]," s\n";
