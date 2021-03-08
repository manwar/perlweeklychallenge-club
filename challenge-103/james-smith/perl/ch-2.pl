#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Data::Dumper qw(Dumper);

is( position( 1606134123, 1614591276, 'filelist.csv'), 'Les Miserables Episode 1: The Bishop (broadcast date: 1937-07-23) @ 00:10:24' );

done_testing();

sub position {
  my ($start, $now, $filename ) =@_;

  ## Slurp in the durations and title's of the episodes,
  ## and while doing this - computer the total length of
  ## all the episodes

  my $tot_duration  = 0;
  open my $fh, q(<), $filename;
  $tot_duration += $_->[0] foreach my @episodes = map { [split m{,?"}] } <$fh>;
  close $fh;

  ## We need the total duration of episodes to work out
  ## how far we have wrapped around the time slots ....

  ## Get the position through the current cycle...

  my $position =  1000 * ($now-$start) % $tot_duration;

  ## Now find which episode that is at that time...

  foreach( @episodes )  {

    ## If the $position variable is less than the length of the episode
    ## then this is the one we want to return....
    ## $position value is the time after the start we want to return...
    return sprintf '%s @ %02d:%02d:%02d',
      $_->[1],
      int( $position / 3600000 )     ,
      int( $position /   60000 ) % 60,
      int( $position /    1000 ) % 60  if $position < $_->[0];

    ## OK - so we now need to reduce position by the length of the
    ## episode and try again....

    $position -= $_->[0];
  }
}

