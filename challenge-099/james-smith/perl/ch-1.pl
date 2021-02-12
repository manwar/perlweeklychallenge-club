#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;

is( file_name_match('abcde','a*e'), 1 );
is( file_name_match('abcde','a*d'), 0 );
is( file_name_match('abcde','?b*d'), 0 );
is( file_name_match('abcde','a*c?e'), 1 );

done_testing();

sub file_name_match {
  ## Convert unix file match pattern with perl regex
  ## Add beginning end of string anchors \A & \Z to the beginning and end
  ## Convert '*' to '.*' & '?' to '.'
  ##    {use r modifier to return string with replacements in}
  my $re = '\A'.($_[1]=~s{[*]}{.*}gr=~s{[?]}{.}gr).'\Z';
  return $_[0] =~ m{$re} ? 1 : 0;
}

