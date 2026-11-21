#!/usr/bin/env perl
use v5.16;
use strict;
use warnings;

sub minimum_steps {
    my ($start, $end, @bank) = @_;
    return 0 if $start eq $end;
    return -1 unless length($start) == length($end);
    my %words = map { $_ => 1 } grep { length($_) == length($start) } @bank;
    return -1 unless exists $words{$end};

    # Two words that agree except at one position share the pattern obtained
    # by removing that position. The position itself is part of the key.
    my %buckets;
    for my $word (keys %words) {
        for my $i (0 .. length($word) - 1) {
            my $key = $i . ':' . substr($word, 0, $i) . substr($word, $i + 1);
            push @{$buckets{$key}}, $word;
        }
    }

    my @queue = ($start);
    my %distance = ($start => 0);
    for (my $head = 0; $head < @queue; ++$head) {
        my $word = $queue[$head];
        for my $i (0 .. length($word) - 1) {
            my $key = $i . ':' . substr($word, 0, $i) . substr($word, $i + 1);
            # The first BFS layer reaching this bucket reaches every member
            # at minimum distance. Later scans of the bucket add no paths.
            my $neighbors = delete $buckets{$key} or next;
            for my $next (@$neighbors) {
                next if exists $distance{$next};
                $distance{$next} = $distance{$word} + 1;
                return $distance{$next} if $next eq $end;
                push @queue, $next;
            }
        }
    }
    return -1;
}

unless (caller) {
    die "Usage: perl ch-2.pl START END [BANK_WORD ...]\n" unless @ARGV >= 2;
    say minimum_steps(@ARGV);
}
1;

