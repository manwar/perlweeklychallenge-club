#! /usr/bin/perl6

use Test;
plan 1;

my @a;
for (1..10) {
  push @a,(^100).pick+10;
}

is-deeply(sleepsort(@a),[sort @a],'example 1');

sub sleepsort(@a) {
  my @r;
  my $channel=Channel.new;
  await (@a).map: -> $e {
    start {
      sleep $e/100;
      $channel.send($e);
    }
  }
  $channel.close;
  for $channel.list -> $r {
    push @r,$r;
  }
  return @r;
}
