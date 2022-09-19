#!/usr/bin/env perl
# Perl weekly challenge 178
# Task 2: Business date
#
# See https://wlmb.github.io/2022/08/15/PWC178/#task-2-business-date
use v5.36;
use DateTime;
use DateTime::Format::DateParse;
use List::Util qw(min);
use POSIX qw(floor);
use experimental qw(try for_list);
my $minutes_per_hour=60;
my $opening_time=9;
my $closing_time=18;
my $minutes_per_day=($closing_time-$opening_time)*$minutes_per_hour;
my $days_per_week=5;
my $minutes_per_week=$days_per_week*$minutes_per_day;

die "Usage: $0 timestamp hours\nto find the next available time\n" unless @ARGV>=2 && @ARGV%2==0;
for my ($ts, $duration)(@ARGV){
    try { say "$ts plus $duration hours->", next_available($ts, $duration)}
    catch($m){say $m}
}

sub next_available($ts, $hours){
    my $minutes=$hours*$minutes_per_hour;
    my $initial=DateTime::Format::DateParse->parse_datetime($ts)->truncate(to=>"minute");
    die "Wrong timestamp" unless $initial->day_of_week <=5 and $initial->hour>=$opening_time
	and $initial->hour < $closing_time;
    # Advance towards end of day
    my $target=$initial->clone;
    my $closing=$target->clone->set(hour=>$closing_time, minute=>0);
    my $minutes_to_close=$closing->subtract_datetime($target)->in_units("minutes");
    my $actual_minutes=min($minutes, $minutes_to_close);
    $target->add(minutes=>$actual_minutes);
    $minutes-=$actual_minutes;
    return $target->datetime(" ") unless $minutes>0;

    # Advance towards end of week
    my $days_to_weekend=$days_per_week-$target->day_of_week;
    my $actual_days=min($days_to_weekend, floor($minutes/$minutes_per_day));
    $target->add(days=>$actual_days);
    $minutes-=$actual_days*$minutes_per_day;
    return  $target->datetime(" ") unless $minutes>0;

    # Advance to next working morning
    $target->add(days=>1)->set(hour=>$opening_time, minute=>0); # next morning
    $target->add(days=>2) if $target->day_of_week==6; # skip weekend

    # Advance full weeks
    my $weeks=floor($minutes/$minutes_per_week);
    $target->add(weeks=>$weeks);
    $minutes-=$weeks*$minutes_per_week;
    return  $target->datetime(" ") unless $minutes>0;

    #Advance full days
    my $days=floor($minutes/$minutes_per_day);
    $target->add(days=>$days);
    $minutes-=$days*$minutes_per_day;
    return  $target->datetime(" ") unless $minutes>0;

    #Advance remaining time
    $target->add(minutes=>$minutes);
    #$minutes=0
    return  $target->datetime(" ");
}
