#!/usr/bin/perl
use strict;
use warnings;

sub count_similar_dominos {
    my @dominos = @_;
    my %domino_counts;
    my $count = 0;

    # Normalize dominos and count occurrences
    foreach my $domino (@dominos) {
        my ($a, $b) = @$domino;
        my $key = join(',', sort ($a, $b));
        $domino_counts{$key}++;
    }

    # Identify dominos that are similar to any other
    foreach my $domino (@dominos) {
        my ($a, $b) = @$domino;
        my $key = join(',', sort ($a, $b));
        if ($domino_counts{$key} > 1) {
            $count++;
        }
    }

    return $count;
}

# Test cases
my @test_cases = (
    { dominos => [[1, 3], [3, 1], [2, 4], [6, 8]], expected => 2 },
    { dominos => [[1, 2], [2, 1], [1, 1], [1, 2], [2, 2]], expected => 3 },
);

foreach my $test (@test_cases) {
    my $result = count_similar_dominos(@{$test->{dominos}});
    print "Input: \@dominos = (";
    print join(', ', map { "[$_->[0], $_->[1]]" } @{$test->{dominos}});
    print ")\n";
    print "Output: $result\n";
    print "Expected: $test->{expected}\n";
    print "-" x 40, "\n";
}
