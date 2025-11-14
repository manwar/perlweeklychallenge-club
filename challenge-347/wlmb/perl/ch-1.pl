#!/usr/bin/env perl
# Perl weekly challenge 347
# Task 1:  Format Date
#
# See https://wlmb.github.io/2025/11/14/PWC347/#task-1-format-date
use v5.36;
use feature qw(try);
die <<~"FIN" unless @ARGV;
    Usage: $0 D0 D1...
    to translate the dates Dn into the format YYYY-MM-DD
    The dates Dn are strings of the form "ordinal month year"
    where ordinal is one of 1st, 2nd, 3rd, 4th, 5th...
    month is one of the abbreviations Jan, Feb, Mar, Apr...
    and year is a four digit year number
    FIN
my @months=qw(jan feb mar apr may jun jul aug sep oct nov dec);
my @lengths=qw(0 31 28 31 30 31 30 31 31 30 31 30 31);
my %month_nums;
my $count=1;
$month_nums{$_}=$count++ for @months;
my %lengths;
for(@ARGV){
    try {
        die "Wrong format; $_" unless /^(\d+)(th|st|nd|rd)\s*([[:alpha:]]{3})\s*(\d{4})$/;
        my ($day, $ending, $month_name, $year)=($1, $2, $3, $4);
        die "Wrong ordinal: $day$ending" unless "$day$ending"=~/(1st|2nd$|3rd|\dth)$/;
        my $month_num = $month_nums{lc $month_name};
        die "Wrong month name: $month_name" unless defined $month_num;
        my $leap=($year%4==0&&$year%100!=0)||($year%400==0);
        die "Non-existing date: $_" unless
            $day>0 && ($day <= $lengths[$month_num] || ($month_num==2 && $leap && $day==29));
        say sprintf "%s -> %s-%02d-%02d", $_, $year, $month_num, $day;
    }
    catch($e){warn $e; }
}
