#!/usr/bin/env perl
use strict;
use warnings;

sub good_string{
  my ($str) = @_;
  my $chars = join '|',map{"$_\u$_|\u$_$_"} 'a'..'z';
  1 while $str =~ s/$chars//;
  $str
}

printf "%s\n",good_string('WeEeekly');
printf "%s\n",good_string('abBAdD');
printf "%s\n",good_string('abc');

