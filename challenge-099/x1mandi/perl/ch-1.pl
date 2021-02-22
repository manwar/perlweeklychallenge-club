#!/usr/bin/perl

use strict;
use warnings;
use diagnostics;
use utf8;
use 5.20.0;
#use re "debug";

my $s = $ARGV[0];
my $p = $ARGV[1];

if (defined $s && defined $p) {
  say look_for_pattern($s, $p);
}


sub look_for_pattern {
  my ($s, $p) = @_;
  #This is to replace ? to . in the regex.
  $p =~ s/\?/./g;
  #Add an anchor to fix the end until regex is looking for a match.
  my $pattern = qr/$p$/;
  say $pattern;
  if ( $s =~ $pattern ) {
      return(1);
  } else { 
  return(0) }
}

#Testing the given examples from PWC
my $str = "abcde";
say look_for_pattern($str, "a*e");
say look_for_pattern($str, "a*d");
say look_for_pattern($str, "?b*d");
say look_for_pattern($str, "a*c?e");

