#!/usr/bin/env perl
# Perl weekly challenge 137
# Task 1: Long year
#
# See https://wlmb.github.io/2021/11/02/PWC137/#task-1-long-year
use v5.12;
use warnings;
use Text::Wrap qw(wrap $columns);
use integer;
$columns=62;
say wrap("", "", grep {is_long_year($_)} ($ARGV[0]//1900..$ARGV[1]//2100));
sub is_long_year {
    my $YY=shift;
    # Skip a day for every 'Gregorian' leap year extrapolating since 0000.
    my $first_weekday=(($YY-1)+($YY-1)/4-($YY-1)/100+($YY-1)/400)%7; # 0=Monday
    my $leap=$YY%400==0||$YY%4==0&&$YY%100!=0;
    return $first_weekday==3 || $leap&&$first_weekday==2;
}
