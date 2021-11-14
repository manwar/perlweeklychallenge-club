#!/usr/bin/env perl
# Week 137 Task 1
# Long Year

use strict;
use warnings;
use feature qw/ say /;
use DateTime;

say join ",", grep {
    DateTime->new( year => $_, month => 12, day => 31 )->week_number() == 53
} ( 1900 .. 2100 );
