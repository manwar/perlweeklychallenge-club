#!/usr/bin/env perl

# Perl Weekly Challenge 187 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-187/

use Modern::Perl;
use DateTime;
use DateTime::Format::Strptime;
use List::Util qw( min max );

sub days_together {
    my($as, $ae, $bs, $be) = @_;
    if ($bs > $ae || $as > $be) { return 0; }
    my $os = max($as, $bs);
    my $oe = min($ae, $be);
    my $days = $oe->delta_days($os)->delta_days()+1;
    return $days;
}

@ARGV==4 or die "usage: ch-1.pl dd-mm dd-mm dd-mm dd-mm\n";
my $strp = DateTime::Format::Strptime->new(pattern=>'%d-%m-%Y');
my @dt = map {$strp->parse_datetime("$_-2023")} @ARGV;  # random non-leap year
say days_together(@dt);
