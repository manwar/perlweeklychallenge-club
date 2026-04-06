#!/usr/bin/env perl

# Perl Weekly Challenge 183 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-183/

use Modern::Perl;
use DateTime;
use DateTime::Format::Strptime;

sub date_diff {
    my($dt1, $dt2) = @_;
    my $diff = $dt2->subtract_datetime($dt1);
    my $years = $diff->in_units('years');
    my $result = $years==0 ? "" : $years==1 ? "1 year " : "$years years ";
    $dt1->add_duration(DateTime::Duration->new(years=>$years));
    my $days = $dt2->delta_days($dt1)->delta_days();
    $result .= $days==0 ? "" : $days==1 ? "1 day" : "$days days";
    return $result;
}

@ARGV==2 or die "usage: ch-2.pl yyyy-mm-dd yyyy-mm-dd\n";
my $strp = DateTime::Format::Strptime->new(pattern=>'%Y-%m-%d');
my @dt = map {$strp->parse_datetime($_)} @ARGV;
say date_diff(@dt);
