#!/usr/bin/env perl
# Author: Steven Wilson
# Date: 2019-12-10
# Week: 038

# TASK #1
# Date Finder Create a script to accept a 7 digits number, where
# the first number can only be 1 or 2. The second and third digits can
# be anything 0-9. The fourth and fifth digits corresponds to the month
# i.e. 01,02,03…,11,12. And the last 2 digits respresents the days in
# the month i.e. 01,02,03….29,30,31. Your script should validate if the
# given number is valid as per the rule and then convert into human
# readable format date.

# RULES 1) If 1st digit is 1, then prepend 20 otherwise 19 to the 2nd
# and 3rd digits to make it 4-digits year.

# 2) The 4th and 5th digits together should be a valid month.

# 3) The 6th and 7th digits together should be a valid day for the above
# month.

# For example, the given number is 2230120, it should print 1923-01-20.

use strict;
use warnings;
use feature qw/ say /;
use DateTime;
use Test::More tests => 7;
use Test::Exception;

ok( find_date(2230120) eq "1923-01-20", "finds date" );
ok( find_date(1230120) eq "2023-01-20", "finds date" );
dies_ok { find_date(22301201) } "dies, number too long";
dies_ok { find_date(230120) } "dies, number too short";
dies_ok { find_date(3230120) } "dies, rule 1";
dies_ok { find_date(2232120) } "dies, rule 2";
dies_ok { find_date(2230140) } "dies, rule 3";

sub find_date {
    my $number = shift;
    my ($first, $second,  $third, $forth, $fifth,
        $sixth, $seventh, $dt,    $year
    );
    die "Not a valid date: $number, stopped"
        unless (
        $number =~ /^(\d{1})(\d{1})(\d{1})(\d{1})(\d{1})(\d{1})(\d{1})$/ );
    $first   = $1;
    $second  = $2;
    $third   = $3;
    $forth   = $4;
    $fifth   = $5;
    $sixth   = $6;
    $seventh = $7;
    die "Not a valid date: $number, stopped"
        unless ( $first == 1 || $first == 2 );
    $year = $first == 1 ? 20 : 19;
    $dt = DateTime->new(
        year  => "$year$second$third",
        month => "$forth$fifth",
        day   => "$sixth$seventh",
    );
    return $dt->ymd;
}
