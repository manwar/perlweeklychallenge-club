#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Data::Dumper qw(Dumper);

is( position( 1606134123, 1614591276, 'filelist.csv'), 'Les Miserables Episode 1: The Bishop (broadcast date: 1937-07-23) - 00:10:24' );

done_testing();

sub position {
  my ($start, $now, $filename ) =@_;

  ## Get the durations and titles of episode..

  open my $fh, q(<), $filename;
  my @episodes = map { [split m{,?"}] } <$fh>;
  close $fh;

  ## Get the total duration of all the episodes
  ## We need this to work out how far we have
  ## wrapped around the time slots ....

  my $tot_duration  = 0;
     $tot_duration += $_->[0] foreach @episodes;

  ## Get the position through the current cycle...

  my $position =            1000 * ($now-$start) -
       $tot_duration * int( 1000 * ($now-$start) / $tot_duration );

  ## Now find which episode that is at that time...

  my $episode_start = 0;
  foreach( @episodes )  {
    ## Return the output.... (in this case we add the duration through episode at the end of the episode name)
    return sprintf '%s - %02d:%02d:%02d',
      $_->[1],
      int( ($position-$episode_start) / 3600000 )     ,
      int( ($position-$episode_start) /   60000 ) % 60,
      int( ($position-$episode_start) /    1000 ) % 60  if $episode_start + $_->[0] > $position;
    $episode_start += $_->[0];
  }
}

