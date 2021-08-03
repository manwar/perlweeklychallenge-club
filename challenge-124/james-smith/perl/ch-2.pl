#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

done_testing();
say match_teams( map { $_*10 } 1..15 );
say match_teams( map { $_*10 } 1..10 );
say match_teams( qw(10 -15 20 30 -25 0 5 40 -5) );
say match_teams( qw(2 3 5 7 11 13 17 19 23 29 31 37 41 43 47 53 59 61 67 71 73 79 83 89 97) );
timethis(1000, sub { match_teams( map { $_*10 } 1..10 ); } );
timethis(1000, sub { match_teams( map { $_*10 } 1..12 ); } );
timethis(1000, sub { match_teams( map { $_*10 } 1..14 ); } );
exit;
timethis(100, sub { match_teams( map { $_*10 } 1..16 ); } );
timethis(100, sub { match_teams( map { $_*10 } 1..18 ); } );
timethis(100, sub { match_teams( map { $_*10 } 1..20 ); } );
timethis(10, sub { match_teams( map { $_*10 } 1..22 ); } );
timethis(10, sub { match_teams( map { $_*10 } 1..24 ); } );
timethis(5, sub { match_teams( map { $_*10 } 1..26 ); } );
timethis(5, sub { match_teams( map { $_*10 } 1..28 ); } );
timethis(5, sub { match_teams( map { $_*10 } 1..30 ); } );

sub match_teams {
  my( $diff, @n ) = @_;
  separate( 1 + int(@n/2), [$diff], [], $diff, my $best = [], @n );
  return "Team 1: [@{$best->[0]}]; Team 2: [@{$best->[1]}]; difference $best->[2]";
}

sub separate {
  my($maxsize,$team1,$team2,$diff,$be,@nums) = @_;
  unless(@nums) {
    if( !defined $be->[0] || $be->[2]>abs $diff ) {
      $be->[0] = $team1;
      $be->[1] = $team2;
      $be->[2] = abs $diff;
    }
    return;
  }
  my $next = shift @nums;
  separate( $maxsize, [@{$team1},$next], $team2, $diff+$next, $be, @nums ) if @{$team1} < $maxsize;
  separate( $maxsize, $team1, [@{$team2},$next], $diff-$next, $be, @nums ) if @{$team2} < $maxsize;
}

##
## Timings
##
## #players  rate
##
##  10       2,273/s
##  12         598/s
##  14         157/s
##  16          41/s
##  18          10/s
##  20        2.68/s
##  22        0.57/s
##  24    ~    6s
##  26    ~   23s
##  28    ~   94s
##  30    ~  365s
