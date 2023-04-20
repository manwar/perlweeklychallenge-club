#!/usr/bin/perl

use v5.16;
use warnings;
use Date::Manip::Recur;
use List::MoreUtils 'part';


# Pick all Mondays to Fridays in 2019, distribute by month and print
# month name and workday count.
say $_->[0]->printf("%b"), ": ", scalar @$_ for
part {$_->printf("%f") - 1}
Date::Manip::Recur->new("0:0:0*1-5:0:0:0", undef, 2019, "2019-12-31")->dates;

