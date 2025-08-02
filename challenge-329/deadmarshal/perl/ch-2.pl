#!/usr/bin/env perl
use strict;
use warnings;

sub nice_string{
  my ($str) = @_;
  my %h;
  $h{lc $_} |= 1 + /[a-z]/ foreach split '',$str;
  foreach my $c(keys %h){
    next if $h{$c} == 3;
    $str =~ s/$c//gi;
  }
  $str
}

printf "%s\n",nice_string('YaaAho');
printf "%s\n",nice_string('cC');
printf "%s\n",nice_string('A');

