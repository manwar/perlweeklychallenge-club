#!/usr/bin/env perl
use strict;
use warnings;

sub friendly_strings {
  (join '',sort split '',$_[0]) eq (join '',sort split '',$_[1])
}

printf "%d\n",friendly_strings('desc','dsec');
printf "%d\n",friendly_strings('fuck','fcuk');
printf "%d\n",friendly_strings('poo','eop');
printf "%d\n",friendly_strings('stripe','sprite');

