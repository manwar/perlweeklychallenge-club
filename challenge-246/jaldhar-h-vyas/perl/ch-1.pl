#!/usr/bin/perl
use 5.030;
use warnings;

sub pick {
    my ($arr, $count) = @_;
    my %results;
    my $picked = 0;

    while ($picked < $count) {
        my $random = $arr->[int(rand(scalar @{$arr}))];
        unless (exists $results{$random}) {
            $results{$random} = 1;
            $picked++;
        }
    }

    return wantarray ? keys %results : [ keys %results];
}

say join "\n", pick([1 .. 49], 6);