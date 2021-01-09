#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;

is( render(group_anagrams(qw(opt bat saw tab pot top was))), '[bat tab] [saw was] [opt pot top]'  );
is( render(group_anagrams(qw(x))), '[x]');

done_testing();

sub render {
  my $anagrams = shift;
  ## To guarantee a unique order we first sort by the "key" string {letters in alphabetical order}
  ## Then alphabetically in each group.
  return join q( ), map { sprintf '[%s]', join q( ), sort @{$anagrams->{$_}} } sort keys %{$anagrams};
}

sub group_anagrams {
  my $anagrams = {};
  ## join q(),sort split m{} - generates a "unique" key for each anagram set (letters in alphabetical order)
  push @{$anagrams->{ join q(),sort split m{}}}, $_ foreach @_;
  return $anagrams;
}

