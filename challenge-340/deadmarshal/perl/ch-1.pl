#!/usr/bin/env perl
use strict;
use warnings;

sub duplicate_removals{
  my ($str) = @_;
  while(1) {
    my $c = 0;
    $str =~ s/(.)\1//g and $c = 1;
    last unless $c
  }
  $str
}

printf "%s\n",duplicate_removals('abbaca');
printf "%s\n",duplicate_removals('azxxzy');
printf "%s\n",duplicate_removals('aaaaaaaa');
printf "%s\n",duplicate_removals('aabccba');
printf "%s\n",duplicate_removals('abcddcba')
