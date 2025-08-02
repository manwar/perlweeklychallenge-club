#!/usr/bin/env perl
use strict;
use warnings;

sub reverse_string{
  $_[0] =~ s/(.*?$_[1])/join '',sort split '',$1/er
}

printf "%s\n",reverse_string('challenge','e');
printf "%s\n",reverse_string('programming','a');
printf "%s\n",reverse_string('champion','b');

