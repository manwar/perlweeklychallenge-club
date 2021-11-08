#!/usr/bin/env perl
# Perl weekly challenge 131
# Task 1:  Consecutive arrays
#
# See https://wlmb.github.io/2021/09/28/PWC132/#task-1-mirror-dates

use v5.12;
use warnings;
use DateTime;
use DateTime::Format::DateParse;
my ($date_s, $current_s)=@ARGV;
my $date=DateTime::Format::DateParse->parse_datetime($date_s)->truncate(to=>'day');
die "Wrong date: ", $date_s//"" unless defined $date;
my $current=DateTime::Format::DateParse->parse_datetime($current_s)->truncate(to=>'day');
die "Wrong date: ", $current_s//"" if not defined $current and defined $current_s;
$current//=DateTime->today->truncate(to=>'day');
my $difference=$current-$date;
my $previous=$date-$difference;
my $next=$current+$difference;
say sprintf "Input: %s,  Current: %s\nOutput: %s, %s",
    map {$_->ymd} ($date, $current, $previous, $next);
