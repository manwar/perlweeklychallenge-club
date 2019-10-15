#!/usr/bin/perl

use strict;
use warnings;

use DateTime;

for (2019 .. 2100){

    my $dt = DateTime->new(year => $_, month => 12, day => 25);

    print $dt->strftime("%Y-%m-%d\n") if $dt->strftime("%A") eq 'Sunday';

}
