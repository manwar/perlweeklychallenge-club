#!/usr/bin/env perl
use strict;
use warnings;

sub text_justifier{
  my $diff = $_[1] - length($_[0]);
  die "Length too short!" if($diff < 0);
  my $l = int($diff / 2);
  my $r = $diff - $l;
  '*' x $l . $_[0] . '*' x $r
}

printf "%s\n",text_justifier('Hi',5);
printf "%s\n",text_justifier('Code',10);
printf "%s\n",text_justifier('Hello',9);
printf "%s\n",text_justifier('Perl',4);
printf "%s\n",text_justifier('A',7);
printf "%s\n",text_justifier('',5);

