#!/usr/bin/env perl
use strict;
use warnings;

sub upper_lower{
  $_[0] =~ tr/A-Za-z/a-zA-Z/r
}

printf "%s\n",upper_lower('pERl');
printf "%s\n",upper_lower('rakU');
printf "%s\n",upper_lower('PyThOn');

