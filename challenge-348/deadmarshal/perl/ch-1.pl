#!/usr/bin/env perl
use strict;
use warnings;

sub string_alike{
  my $h = length($_[0]) / 2;
  my $a = (substr $_[0],0,$h) =~ tr/aeiouAEIOU//;
  my $b = (substr $_[0],$h) =~ tr/aeiouAEIOU//;
  $a == $b && $a != 0
}

printf "%d\n",string_alike('textbook');
printf "%d\n",string_alike('book');
printf "%d\n",string_alike('AbCdEfGh');
printf "%d\n",string_alike('rhythmmyth');
printf "%d\n",string_alike('UmpireeAudio')

