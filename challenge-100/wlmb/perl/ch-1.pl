#!/usr/bin/env perl
# Perl weekly challenge 100
# Task 1: Fun Time
#
# See https://wlmb.github.io/2021/02/15/PWC100/#task-1-fun-time
use strict;
use warnings;
use v5.12;

sub usage {
    say @_ if @_;
    say <<END;
    Converts time between 12 and 24 hour formats
    Usage;
       ./ch-1.pl time1 time2 ...
       Each argument must have the format "hh:mm:ss ampm"
       where the minutes and seconds are optional and
       ampm is either am or pm or null.
       If ampm is given, the hour should be not greater than 12 nor
       smaller than 1. If not, hour should be smaller than 24.
       Minutes and seconds should be smaller than 60.
END
    exit 1;
}

# The conversion rules are so crazy I'd better use tables.
# There is no 24-th hour, 12 pm< 1pm, 12am < 1am, there is 00, but not 00AM
my @from_am=(undef,      1, 2, 3, 4, 5, 6, 7, 8, 9,1 ,11, 0); # No 00AM
my @from_pm=(undef,     13,14,15,16,17,18,19,20,21,22,23,12); #No 24
my @to_am=  (           12, 1, 2, 3, 4, 5, 6, 7, 8, 9,10,11); #00 is 12AM
my @to_pm=  ((undef)x12,12, 1, 2, 3, 4, 5, 6, 7, 8, 9,10,11); #12 is 12PM but 13 is 1PM
foreach(@ARGV){
    #Match allowing one or two digit hours, optional minutes, optional seconds and am,pm indicator
    usage("Bad format: $_") unless /^(\d\d?)(:(\d\d?))?(:(\d\d?))?\s*(am|pm)?\s*$/i;
    my ($hour,$minute,$second,$indicator)=($1,$3,$5,$6//"");
    usage("Minute should be less than 60: $_") if defined $minute and $minute>=60;
    usage("Second should be less than 60: $_") if defined $second and $second>=60;
    my ($newhour,$newindicator)=
	lc $indicator eq "am"?   ($from_am[$hour],"")
	:lc $indicator eq "pm"?  ($from_pm[$hour],"")
	:defined $to_am[$hour]?($to_am[$hour],"am")
	:defined $to_pm[$hour]?($to_pm[$hour],"pm")
	:(undef,undef);
    usage("Bad hour: $_") unless defined $newhour;
    say sprintf("Input:\t%s\nOutput:\t%02d", $_, $newhour),
        (defined $minute?sprintf(":%02d", $minute):""),
	(defined $second?sprintf(":%02d",$second):""),
	" $newindicator";
}
