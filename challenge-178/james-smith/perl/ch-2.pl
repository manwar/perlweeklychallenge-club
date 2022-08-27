#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);
use Time::Local;

add_date( '2022-08-16 04:30', 45*3 + 2*9 + 1.25 );

my @months = (31,31,28,31,30,31,30,31,31,30,31,30,31);

my @L = (31,31,28,31,30,31,30,31,31,30,31,30,31);

sub add_date {
  my ($dur,$yr,$mth, $day,$hr,$min) = (pop,shift =~ m{(\d+)}g);
  my $time = timelocal( 0,$min,$hr,$day,$mth-1,$yr);
  my $dow  = [localtime( $time )]->[6];
  my $weeks = int( $dur / 45 );
  my $days  = int( ($dur%45) / 9 );
  my $hours = $dur - $weeks * 45 - $days * 9;
  $hr = 9,  $min = 0 if $hr < 9;
  $hr = 18, $min = 0 if $hr > 18;
  if( $hours + $hr > 18 ) {
    $hr  += int($hours);
    $min += 60 * ( $hours - int($hours) );
    $min -= 60, $hr++ if $min > 60;
    $min = `
  }
  if( $days > 5 - $dow ) {
    $dow = $days - 5; $weeks ++;
    $row
  }
}

