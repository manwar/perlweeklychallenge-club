#!/usr/bin/perl
use 5.038;
use warnings;

sub wildcardPlayoffs($results) {
    my @winners = (2, 7, 3, 6, 4, 5);
    my @week2 = (1);

    for my $i (0 ..2) {
        push @week2, $winners[2 * $i + (($results->[$i] eq 'H') ? 0 : 1)];
    }

    return sort @week2;
}

sub divisionalPlayoffs($week2, $results) {
    my @winners = (0, 3, 1, 2);
    my @week3;

    for my $i (0 .. 1) {
        push @week3, $week2->[$winners[2 * $i + (($results->[$i] eq 'H') ? 0 : 1)]];
    }

    return sort @week3;
}

sub conferenceFinals($week3, $result) {
    return $result eq 'H' ? ($week3->[0], $week3->[1]) : ($week3->[1], $week3->[0]);
}

my ($result) = @ARGV;

unless ($result && $result =~ /^[AH]{6}$/) {
    die "Need a string of 6 A or H characters\n";
}

my @results = split //, $result;

my @week2 = wildcardPlayoffs([@results[0..2]]);

my @week3 = divisionalPlayoffs([@week2], [@results[3 .. 4]]);

my ($winner, $loser) = conferenceFinals(\@week3, $results[5]);

say "Team $winner defeated Team $loser"
