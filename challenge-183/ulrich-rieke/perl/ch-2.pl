#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use Date::Calc qw ( Delta_Days leap_year ) ;

sub formatOutput {
  my $value = shift ;
  my $unit = shift ;
  if ( $value == 1 ) {
      return "1 $unit" ;
  }
  if ( $value > 1 ) {
      return "$value $unit" . "s" ;
  }
}

say "Please enter a start date in the form yyyy-mm-dd!" ;
my $line = <STDIN> ;
chomp $line ;
my ( $year1 , $month1 , $days1 ) ;
my ( $year2 , $month2 , $days2 ) ;
while ( $line !~ /\A(\d{4})-(\d{2})-(\d{2})\z/ ) {
  say "Enter the date as yyyy-mm-dd!" ;
  $line = <STDIN> ;
  chomp $line ;
}
if ( $line =~ /\A(\d{4})-(\d{2})-(\d{2})\z/ ) {
  $year1 = $1 ;
  $month1 = $2 ;
  $days1 = $3 ;
}
say "Please enter an end date in the form yyyy-mm-dd!" ;
$line = <STDIN> ;
chomp $line ;
while ( $line !~ /\A(\d{4})\-(\d{2})\-(\d{2})\z/ ) {
  say "Enter the date as yyyy-mm-dd!" ;
  $line = <STDIN> ;
  chomp $line ;
}
if ( $line =~ /\A(\d{4})-(\d{2})-(\d{2})\z/ ) {
  $year2 = $1 ;
  $month2 = $2 ;
  $days2 = $3 ;
}
my $toBeSubtracted = 0 ;
if ( $year2 - $year1 >= 1 ) {
  if ( $year2 - $year1 == 1 ) {
      if ( leap_year( $year1 )) {
    if ( $month1 == 1 && $days1 == 1 ) {
        $toBeSubtracted++ ;
    }
      }
      if ( leap_year( $year2 )) {
    if ( $month2 == 12 && $days2 == 31 ) {
        $toBeSubtracted++ ;
    }
      }
  }
  if ( leap_year( $year2 ) ) {
      if ( $month2 == 31 && $days2 == 31 ) {
    $toBeSubtracted++ ;
      }
  }
  if ( ($year2 - $year1 ) > 1 ) {
      for my $y ( $year1 + 1 .. $year2 - 1 ) {
    if ( leap_year( $y ) ) {
        $toBeSubtracted++ ;
    }
      }
  }
}
my $diffDays = Delta_Days( $year1 , $month1 , $days1 , $year2 , $month2 ,
      $days2 ) ;
$diffDays -= $toBeSubtracted ;
my $ys = int( $diffDays / 365 ) ;
my $ds = $diffDays - $ys * 365 ;
if ( $ys > 0 ) {
  say formatOutput( $ys , "year" ) . " " . formatOutput( $ds , "day" ) ;
}
else {
  say formatOutput( $ds , "day" ) ;
}
