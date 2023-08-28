#!/usr/bin/env perl
use strict;
use warnings;

sub senior_citizens
{
  scalar grep{substr($_,-4,2) >= 60} @{$_[0]};
}

printf "%d\n",senior_citizens(["7868190130M7522",
			       "5303914400F9211",
			       "9273338290F4010"]);
printf "%d\n",senior_citizens(["1313579440F2036",
			       "2921522980M5644"]);

