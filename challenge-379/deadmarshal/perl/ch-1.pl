#!/usr/bin/env perl
use strict;
use warnings;

sub reverse_string{
  my ($s) = @_;
  my $res = '';
  $res .= chop $s while length $s;
  $res
}

printf "%s\n",reverse_string('');
printf "%s\n",reverse_string('reverse the given string');
printf "%s\n",reverse_string('Perl is Awesome');
printf "%s\n",reverse_string('v1.0.0-Beta!');
printf "%s\n",reverse_string('racecar');
  
