#!/usr/bin/env perl
use strict;
use warnings;

sub split_string{
  $_[0] =~ tr/aeiouy// % 2 == 0
}

printf "%d\n",split_string('perl');
printf "%d\n",split_string('book');
printf "%d\n",split_string('good morning');

