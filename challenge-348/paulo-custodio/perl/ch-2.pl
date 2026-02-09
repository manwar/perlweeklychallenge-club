#!/usr/bin/env perl

use Modern::Perl;

@ARGV==2 or die "Usage: $0 HH:MM HH:MM\n";

my $t1 = minutes($ARGV[0]);
my $t2 = minutes($ARGV[1]);
say num_ops($t1, $t2);

sub num_ops {
    my($t1, $t2) = @_;
    $t2 += minutes("24:00") if $t2 < $t1;
    my $count = 0;
    while ($t1 < $t2) {
        for my $delta (60, 15, 5, 1) {
            while ($t1 + $delta <= $t2) {
                $count++;
                $t1 += $delta;
            }
        }
    }
    return $count;
}

sub minutes {
    my($hhmm) = @_;
    my($h, $m) = split /:/, $hhmm;
    return $h*60+$m;
}
