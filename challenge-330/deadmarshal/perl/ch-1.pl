#!/usr/bin/env perl
use strict;
use warnings;

sub clear_digits{
  my ($str) = @_;
  1 while($str =~ s/\D\d//);
  $str
}

printf "%s\n",clear_digits('cab12');
printf "%s\n",clear_digits('xy99');
printf "%s\n",clear_digits('pa1erl');

