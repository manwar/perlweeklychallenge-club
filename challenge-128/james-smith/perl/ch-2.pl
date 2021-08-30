#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my @TESTS = (
  [ [qw(11:20 14:30)],
    [qw(11:50 15:00)],
    1 ],
  [ [qw(10:20 11:00 11:10 12:20 16:20 19:00)],
    [qw(10:30 13:20 12:40 12:50 20:20 21:20)],
    3 ]
);

is( bump_platform(             $_->[0], $_->[1] ), $_->[2] ) foreach @TESTS;
is( bump_platform_keep_trains( $_->[0], $_->[1] ), $_->[2] ) foreach @TESTS;

done_testing();

sub bump_platform {
  my @arr = @{shift @_};
  my @dep = @{shift @_};
  my @platforms = ();
  OUTER: foreach my $st (@arr) {
    foreach(0..$#platforms) {
      ## If train fits on platform - we extend the last departure time
      ## and start working with new train
      ($platforms[$_] = shift @dep) && (next OUTER) if $st gt $platforms[$_];
    }
    ## Otherwise we start a new platform...
    push @platforms,shift @dep;
  }
  return scalar @platforms;
}

sub bump_platform_keep_trains {
  my @arr = @{shift @_};
  my @dep = @{shift @_};
  my($train_no, @platforms) = (0);

  OUTER: foreach my $st (@arr) {
    foreach(@platforms) {
      ## If we can fit on this platform - add train details
      ## and go to the next train
      (push @{$_}, [ $st, (shift @dep), ++$train_no ]) &&
        (next OUTER) if $st gt $_->[-1][1];
    }
    ## No room on any of the existing platforms - so we create
    ## a new one and push the train
    push @platforms, [ [ $st, (shift @dep), ++$train_no ] ];
  }
  ## Display details about trains on platform.
  say '  ',
    join '  ',
    map { "Train $_->[2]: $_->[0]-$_->[1]" }
    @{$_} foreach @platforms;
  ## Return the number of platforms
  return scalar @platforms;
}


