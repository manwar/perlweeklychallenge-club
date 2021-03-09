#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Data::Dumper qw(Dumper);

is( position( 1606134123, 1614591276, 'filelist.csv'),
  'Les Miserables Episode 1: The Bishop (broadcast'.
    ' date: 1937-07-23) @ 00:10:24' );

done_testing();

sub position {
  my ($start, $now, $filename ) = @_;

  ## Slurp in the durations and title's of the episodes,
  ## and while doing this - computer the total length of
  ## all the episodes.
  ##
  ## A neat feature of perl is that we can define
  ## variables anywhere in the statement not just at the
  ## beginning - so we can do the slurp in a single line
  ##
  ## Rather than using a full CSV library we split on ,"
  ## as this works for the set of data that we have in
  ## the problem but we could use Text::CSV for more
  ## complex strings.
  ##
  ## Note values in @episodes are triples (the third is
  ## any part of the string after the second " which
  ## happens just to be "\n"

  my $tot_duration  = 0;
  open my $fh, q(<), $filename;
  $tot_duration += $_->[0]
    foreach my @episodes = map { [split m{,?"}] } <$fh>;
  close $fh;

  ## We need the total duration of episodes to work out
  ## how far we have wrapped around the time slots ....

  ## Get the position through the current cycle...
  ## Note we have to multiple the difference by 1000
  ## as the as the tot_duration is in milliseconds and
  ## now/start in seconds.

  my $position =  1000 * ($now-$start) % $tot_duration;

  ## Now find which episode that is at that time...

  foreach( @episodes )  {

    ## If the $position variable is less than the length
    ## of the episode then this is the one we want to
    ## return....
    ##
    ## $position value is the time after the start we
    ## want to return... As it is milliseconds we don't
    ## just divide by 60 & 3600 we have to multiply
    ## these divisors by 1000
    ##
    ## Rather than return an array of two values name
    ## and position - we return as a string - this is
    ## to make the test call easier byt we could just
    ## return [ $_->[0], $position ] which is the second
    ## half of the sprintf '%02d:%02d:%02d', ....

    return sprintf '%s @ %02d:%02d:%02d',
      $_->[1],
      int( $position/3600000 )     ,
      int( $position/  60000 ) % 60,
      int( $position/   1000 ) % 60  if $position < $_->[0];

    ## OK - rather than "moving the start time" - we just
    ## reduce position by the length of the episode and
    ## try again....

    $position -= $_->[0];
  }
}

