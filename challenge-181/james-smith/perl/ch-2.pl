#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my @TESTS = (
  [ 0, 1 ],
);

say $_ for hot_day( get_file( 'temp.txt' ) );
say '';
say $_ for hot_day_single( 'temp.txt' );
say '';

sub get_file {
  open my $fh, q(<), $_[0];
  map { m{(\d{4}-\d\d-\d\d),\s+(\d+)}?[$1,$2]:() } sort <$fh>
}

sub hot_day {
  my $day = shift;
  map { $_->[1] > $day->[1] ? $_->[0] : (), ($day=$_)x 0 } @_
}

sub hot_day_single {
  die "Unknown file $_[0]" unless open my $fh, q(<), $_[0];
  my $t;
  map { m{ (\d\d\d\d-\d\d-\d\d) , \s+ (\d+) }x
        ? ( $t && $2 > $t ? $1 :() , ( $t = $2 ) x 0 )
        : ()
      } sort <$fh>;
}

