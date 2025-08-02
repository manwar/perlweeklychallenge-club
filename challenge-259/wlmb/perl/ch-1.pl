#!/usr/bin/env perl
# Perl weekly challenge 259
# Task 1:  Banking Day Offset
#
# See https://wlmb.github.io/2024/03/04/PWC259/#task-1-banking-day-offset
use v5.36;
use DateTime;
use DateTime::Format::DateParse qw(parse_datetime);
use List::AllUtils qw(uniq_by);
use POSIX qw(floor);
die <<~"FIN" unless @ARGV >= 2;
    Usage ch-1.pl S D [B1 B2...]
    to bump daye S by D days skipping weekends and
    the (optional) bank holidays B1 B2...
    FIN
my ($start_str, $offset, @bank_str)=@ARGV;
my ($start, @bank)=  # convert to dates
    map
    {DateTime::Format::DateParse->parse_datetime($_)->truncate(to=>'day')}
    ($start_str, @bank_str);
my $fullweeks=floor($offset/5);
my $remaining=$offset%5;
my $end=$start->clone;
my $weekday=$end->day_of_week;
$end->add(days=>8-$weekday), $weekday=1 if $weekday>5;
$end->add(days=>7*$fullweeks+$remaining);
skip_weekend($end);
bank_adjust($_,$start,$end) for
    sort {DateTime->compare($a, $b)} uniq_by {"".$_} @bank; # remove duplicate dates and sort
say "Start: $start_str. Offset $offset. Holidays: @bank_str -> ", $end->ymd;
sub skip_weekend($date){
    my $weekday=$date->day_of_week;
    $date->add(days=>2) if $weekday>5;
}
sub bank_adjust($date, $start, $end){
    return if $date->day_of_week >5 ||
	DateTime->compare($date, $start) < 0 || DateTime->compare($date, $end) > 0;
    $end->add(days=>1);
    $end->add(days=>2) if $end->day_of_week>5; # skip weekend
}
