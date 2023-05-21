#!//usr/bin/perl
use 5.36.0;
use strict;

my @list = (31, 2, 4, 10);
say join('', sort { $b cmp $a } @list);
