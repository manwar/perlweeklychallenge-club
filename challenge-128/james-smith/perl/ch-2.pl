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
  #shift @{$arr};
  my @plat = ();#(shift @{$dep});
  OUTER: foreach my $st (@arr) {
    foreach(0..$#plat) {
      next unless $st gt $plat[$_];
      $plat[$_] = shift @dep;
      next OUTER;
    }
    push @plat,shift @dep;
  }
  return scalar @plat;
}

sub bump_platform_keep_trains {
  my @arr = @{shift @_};
  my @dep = @{shift @_};
  my $t = 0;
  my @plat;
  OUTER: foreach my $st (@arr) {
    foreach(@plat) {
      next unless $st gt $_->[-1][1];
      push @{$_}, [ $st, (shift @dep), ++$t ];
      next OUTER;
    }
    push @plat, [ [ $st, (shift @dep), ++$t ] ];
  }
  say '  ',join '  ', map { "Train $_->[2]: $_->[0]-$_->[1]" } @{$_} foreach @plat;
  return scalar @plat;
}

