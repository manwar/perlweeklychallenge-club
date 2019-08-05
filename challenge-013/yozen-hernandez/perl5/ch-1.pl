#!/usr/bin/env perl

use strict;
use warnings;
use feature qw(say state);
use DateTime;
use DateTime::Duration;

# Write a script to print the date of last Friday of every month of a given
# year. For example, if the given year is 2019 then it should print the
# following:
#
# 2019/01/25
# 2019/02/22
# 2019/03/29
# 2019/04/26
# 2019/05/31
# 2019/06/28
# 2019/07/26
# 2019/08/30
# 2019/09/27
# 2019/10/25
# 2019/11/29
# 2019/12/27
 
my $year = shift or die "Usage: $0 <year>\n";

my $dt = DateTime->new(
    month => 1,
    day   => 1,
    year  => $year
);
my $add_week = DateTime::Duration->new( weeks => 1 );
my $add_day  = DateTime::Duration->new( days  => 1 );

while ( $dt->day_of_week() != 5 ) { $dt->add($add_day); }

my %last_fri;
while ( $dt->year == $year ) {
    $last_fri{ $dt->month } = $dt->ymd("/");
    $dt->add($add_week);
}

{
    local $, = "\n";
    say @last_fri{ sort { $a <=> $b } keys %last_fri };
}
