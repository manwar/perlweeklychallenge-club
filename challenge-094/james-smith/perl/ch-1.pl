#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;

warn render(group_anagrams(qw(opt bat saw tab pot top was)));
warn render(group_anagrams(qw(x)));

is( render(group_anagrams(qw(opt bat saw tab pot top was))), '[bat tab] [saw was] [opt pot top]'  );
is( render(group_anagrams(qw(x))), '[x]');


done_testing();

sub render {
  my $anagrams = shift;
  return join q( ), map { sprintf '[%s]', join q( ), sort @{$anagrams->{$_}} } sort keys %{$anagrams};
}

sub group_anagrams {
  my $anagrams = {};
  push @{$anagrams->{ join q(),sort split m{}}}, $_ foreach @_;
  return $anagrams;
}

