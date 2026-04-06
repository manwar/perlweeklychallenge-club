#!/usr/bin/env perl

# Perl Weekly Challenge 181 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-181/

use Modern::Perl;
use DateTime;

sub read_data {
    my($file) = @_;
    open(my $f, "<", $file) or die "open $file: $!";
    my @temps;
    while (<$f>) {
        /^\s*(\d+)-(\d+)-(\d+)\s*,\s*(\d+)\s*$/ or die "cannot parse: $_";
        my $dt = DateTime->new(year=>$1, month=>$2, day=>$3);
        push @temps, [$dt, $4];
    }
    return @temps;
}

sub print_temp_higher {
    my(@temps) = @_;
    @temps = sort {$a->[0]->ymd cmp $b->[0]->ymd} @temps;
    for my $i (1..$#temps) {
        # date difference
        my $dt_diff = $temps[$i][0]->subtract_datetime($temps[$i-1][0]);
        if ($temps[$i][1] > $temps[$i-1][1] &&
            $dt_diff->in_units('days') == 1) {
            say $temps[$i][0]->ymd;
        }
    }
}

@ARGV==1 or die "usage: ch-2.pl file\n";
print_temp_higher(read_data(shift));
